module HealthCheck
  class Config
    attr_reader :plugins

    PLUGINS = [:ping]

    PLUGINS.each do |plugin_name|
      define_method plugin_name do |&_block|
        require "health_check/plugins/#{plugin_name}"

        add_plugin("HealthCheck::Plugins::#{plugin_name.capitalize}".constantize)
      end
    end

    private

      def add_plugin(plugin_class)
        (@plugins ||= Set.new) << plugin_class
        plugin_class
      end
  end
end
