require "tty/spinner"

module HubStore
  class Ui
    def start(msg)
      @spinner = TTY::Spinner.new(":spinner #{msg}...", format: :dots_3)
      @spinner.auto_spin
    end

    def stop(msg)
      @spinner.success("(#{msg})")
    end

    def log(msg)
      puts msg
    end
  end
end
