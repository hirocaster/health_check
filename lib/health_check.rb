require "health_check/engine"
require "health_check/plugins/base"
require "health_check/plugins/ping"

module HealthCheck

  extend self

  def all_check(request: nil)
    plugins = [HealthCheck::Plugins::Ping]

    results = plugins.map { |plugin| result plugin, request }

    {
      results: results.reduce({}, :merge),
      status: results.all? { |result| result.values.first[:status] == "OK" } ? "OK" : "NG"
    }
  end

  private

    def result(plugin, request)
      monitor = plugin.new(request: request)
      monitor.check!

      {
        plugin.name.demodulize.downcase => {
          message: "",
          status: "OK",
          timestamp: Time.now.to_s(:db)
        }
      }

    rescue => exception

      {
        plugin.name.demodulize.downcase => {
          message: exception.message,
          status: "NG",
          timestamp: Time.now.to_s(:db)
        }
      }

    end
end
