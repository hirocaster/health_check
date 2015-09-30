module HealthCheck
  module Plugins
    class Base
      def check!(request: nil)
        @request = request
      end

      def name
        self.class.name.demodulize.downcase
      end
    end
  end
end
