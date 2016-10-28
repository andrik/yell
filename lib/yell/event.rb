# encoding: utf-8

require 'time'
require 'socket'
require 'english'

module Yell #:nodoc:
  # Yell::Event.new( :info, 'Hello World', { :scope => 'Application' } )
  # #=> Hello World scope: Application
  class Event
    # regex to fetch caller attributes
    CallerRegexp = /^(.+?):(\d+)(?::in `(.+)')?/

    # jruby and rubinius seem to have a different caller
    CallerIndex = defined?(RUBY_ENGINE) && %w(rbx jruby).include?(RUBY_ENGINE) ? 1 : 2

    # Prefetch those values (no need to do that on every new instance)
    @@hostname = begin
                    Socket.gethostname
                  rescue
                    nil
                  end

    # Accessor to the log level
    attr_reader :level

    # Accessor to the log message
    attr_reader :messages

    # Accessor to the time the log event occured
    attr_reader :time

    # Accessor to the logger's name
    attr_reader :name

    def initialize(logger, level, *messages)
      @time = Time.now
      @name = logger.name
      @level = level
      @messages = messages
    end

    # Accessor to the hostname
    def hostname
      @@hostname
    end

    # Accessor to the progname
    def progname
      $PROGRAM_NAME
    end

    # Accessor to the PID
    def pid
      $PROCESS_ID
    end

    # Accessor to the thread's id
    def thread_id
      Thread.current.object_id
    end
  end
end
