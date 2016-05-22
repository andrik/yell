# encoding: utf-8
module Yell #:nodoc:
  module Helpers #:nodoc:
    module Formatter #:nodoc:
      # Set the format for your message.
      def formatter=(pattern)
        @__formatter__ = case pattern
                         when Yell::Formatter then pattern
                         else Yell::Formatter.new(*pattern)
        end
      end
      alias format= formatter=

      def formatter
        @__formatter__
      end
      alias format formatter

      private

      def reset!(options = {})
        @__formatter__ = Yell::Formatter.new
        # FIXME: :format is deprecated in future versions --R
        self.formatter = Yell.__fetch__(options, :format, :formatter)

        super(options)
      end
    end
  end
end
