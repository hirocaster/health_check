require "redis"

module HealthCheck
  module Plugins
    class RedisException < StandardError; end

    class Redis < Base
      def check!(request: nil)
        value = Time.now.to_s(:db)

        check_urls.each do |host|
          @redis = ::Redis.new(host: host)
          @redis.set key(request), value

          fetched_value = @redis.get key(request)

          fail "differende values (now: #{time}, fetched: #{fetched_value})" if fetched_value != value

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
    end
  end
end
