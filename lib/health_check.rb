require "health_check/engine"
require "health_check/config"
require "health_check/plugins/base"

module HealthCheck
  extend self

  def all_check(request: nil)
    plugins = HealthCheck.config.plugins

    results = plugins.map { |plugin| result plugin, request }

    {
      results: results.reduce({}, :merge),
      status: results.all? { |result| result.values.first[:status] == "OK" } ? "OK" : "NG"
    }
  end

  def config
    @config ||= Config.new
  end

  def configure(&block)
    config.instance_eval(&block)
  end

  private

  def result(plugin, request)
    message = plugin.check!(request: request)

    {
      plugin.name.demodulize.downcase => {
        message: message,
        status: "OK",
        timestamp: Time.current.to_s(:db)
      }
    }

  rescue => exception
    error_result exception, plugin
  end

  def error_result(exception, plugin)
    {
      plugin.name.demodulize.downcase => {
        message: exception.message,
        status: "NG",
        timestamp: Time.current.to_s(:db)
      }
    }
  end
end
