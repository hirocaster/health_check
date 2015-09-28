module HealthCheck
  module Plugins
    class Base
      attr_reader :request

      def initialize(request: nil)
        @request = request
      end

      def check!
        raise NotImplementedError
      end
    end
  end
end
