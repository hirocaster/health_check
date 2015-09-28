require "redis"

module HealthCheck
  module Plugins
    class RedisException < StandardError; end

    class Redis < Base
      def check!
        value = Time.now.to_s(:db)

        redis = ::Redis.new
        redis.set key, value

        fetched_value = redis.get key

        raise "differende values (now: #{time}, fetched: #{fetched_value})" if fetched_value != value
      rescue Exception => e
        raise RedisException, e.message
      ensure
        redis.client.disconnect
      end

      private

        def key
          @key ||= ['health_check', request.try(:remote_ip)].join(':')
        end
    end
  end
end
