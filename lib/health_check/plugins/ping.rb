module HealthCheck
  module Plugins
    class PingException < StandardError; end

    class Ping < Base

      def check!(request: nil)
      end

    end
  end
end
