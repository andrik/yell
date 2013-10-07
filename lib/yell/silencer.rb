# encoding: utf-8
module Yell #:nodoc:

  # The +Yell::Silencer+ is your handly helper for stiping out unwanted log messages.
  class Silencer

    def initialize( *patterns )
      @patterns = patterns.dup
    end

    # Add one or more patterns to the silencer
    #
    # @example
    #   add( 'password' )
    #   add( 'username', 'password' )
    #
    # @example Add regular expressions
    #   add( /password/ )
    #
    # @return [Array] All set patterns
    def add( *patterns )
      @patterns = @patterns | patterns.compact
    end

    # Clears out all the messages that would match any defined pattern
    #
    # @example
    #   call(['username', 'password'])
    #   #=> ['username]
    #
    # @return [Array] The remaining messages
    def call( messages )
      messages = messages.is_a?(Array) ? messages : [messages]
      return messages if @patterns.empty?

      messages.reject { |m| matches?(m) }
    end

    # Get a pretty string
    def inspect
      "#<#{self.class.name} patterns: #{@patterns.inspect}>"
    end

    # @private
    def patterns
      @patterns
    end


    private

    # Check if the provided message matches any of the defined patterns.
    #
    # @example
    #   matches?('password')
    #   #=> true
    #
    # @return [Boolean] true or false
    def matches?( message )
      @patterns.any? { |pattern| message.respond_to?(:match) && message.match(pattern) }
    end

  end
end

