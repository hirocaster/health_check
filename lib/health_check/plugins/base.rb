module HealthCheck
  module Plugins
    class Base

      def initialize(request: nil)
      end

      def check!
        raise NotImplementedError
      end
    end
  end
end
