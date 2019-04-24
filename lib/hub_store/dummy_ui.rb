module HubStore
  class DummyUi
    def method_missing(method, *args, &block)
      # noop
    end
  end
end
