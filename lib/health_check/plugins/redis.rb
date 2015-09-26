module HealthCheck
  module Plugins
    class RedisException < StandardError; end

    class Redis < Base

      def initialize(request: nil)
      end

      def check!
      rescue Exception => e
        raise RedisException, e.message
      end

    end
  end
end
