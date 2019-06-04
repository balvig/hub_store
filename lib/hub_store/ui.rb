require "pastel"
require "tty/spinner"

module HubStore
  class Ui
    FORMAT = ":spinner :title :status"

    def initialize
      @spinner = TTY::Spinner.new(FORMAT, format: :dots_3, hide_cursor: true, interval: 20)
    end

    def info(progname, &block)
      case progname
      when HubLink::START
        start block.call
      when HubLink::FINISH
        stop block.call
      else
        update block.call
      end
    end

    def start(msg)
      spinner.update(title: format(msg), status: nil)
      spinner.auto_spin
    end

    def update(msg)
      spinner.update(status: msg)
    end

    def stop(msg)
      spinner.update(status: nil)
      spinner.success("(#{format msg, :green})")
    end

    private

      attr_reader :spinner

      def format(msg, options = [])
        options << :bold if msg.start_with?("*")
        pastel.decorate msg, *options
      end

      def pastel
        @_pastel ||= Pastel.new
      end
  end
end
