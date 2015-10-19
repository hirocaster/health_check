require "redis"

module HealthCheck
  module Plugins
    class RedisException < StandardError; end

    class Redis < Base
      def check!(request: nil)
        value = Time.now.to_s(:db)

        check_urls.each do |host|
          @redis = ::Redis.new(host: host)
          key = key(request)

          @redis.set key, value
          featch_and_validate! key, value

          @redis.client.disconnect
        end
      rescue StandardError => e
        @redis.client.disconnect if @redis
        raise RedisException, e.message
      end

      def check_urls
        @check_urls ||= ["redis://127.0.0.1:6380/"]
      end

      attr_writer :check_urls

      private

      def key(request)
        @key ||= ["health_check", request.try(:remote_ip)].join(":")
      end

      def featch_and_validate!(key, value)
        fetched_value = @redis.get key
        fail "differende values (now: #{value}, fetched: #{fetched_value})" if fetched_value != value
      end
    end
  end
end
