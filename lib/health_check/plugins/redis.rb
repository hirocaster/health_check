require "redis"

module HealthCheck
  module Plugins
    class RedisException < StandardError; end

    class Redis < Base
      def check!
        @check_urls = []

        if request && request.params[:redis_check_urls]
          @check_urls = request.params[:redis_check_urls].split(",")
        else
          @check_urls << "redis://127.0.0.1:6380/"
        end

        value = Time.now.to_s(:db)

        @check_urls.each do |host|
          @redis = ::Redis.new(:host => host)
          @redis.set key, value

          fetched_value = @redis.get key

          raise "differende values (now: #{time}, fetched: #{fetched_value})" if fetched_value != value

          @redis.client.disconnect
        end
      rescue Exception => e
        @redis.client.disconnect if @redis
        raise RedisException, e.message
      end

      private

        def key
          @key ||= ['health_check', request.try(:remote_ip)].join(':')
        end
    end
  end
end
