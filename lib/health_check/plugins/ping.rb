module HealthCheck
  module Plugins
    class PingException < StandardError; end

    class Ping < Base
      def check!(*)
      end
    end
  end
end
