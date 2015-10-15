module HealthCheck
  class Config
    PLUGINS = [:ping, :database, :redis]

    PLUGINS.each do |plugin_name|
      define_method plugin_name do |&_block|
        require "health_check/plugins/#{plugin_name}"

        add_plugin("HealthCheck::Plugins::#{plugin_name.capitalize}".constantize)
      end
    end

    def plugins
      @plugins.values
    end

    private

    def add_plugin(plugin_class)
      @plugins ||= {}

      if @plugins.key? plugin_class
        @plugins.fetch plugin_class
      else
        plugin = plugin_class.new
        @plugins[plugin_class] = plugin
        plugin
      end
    end
  end
end
