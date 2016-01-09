module HealthCheck
  module Plugins
    class DatabaseException < StandardError; end

    class Database < Base
      attr_writer :class_names

      def check!(request: nil)
        super

        message = {}

        class_names.each do |check_klass|
          ActiveRecord::Migrator.current_version check_klass.connection
          message[check_klass.name] = "OK"
        end

        message
      rescue StandardError => e
        raise DatabaseException, e.message
      end

      def class_names
        @class_names ||= [ActiveRecord::Base]
      end
    end
  end
end
