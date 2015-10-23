module HealthCheck
  module Plugins
    class DatabaseException < StandardError; end

    class Database < Base
      def check!(request: nil)
        super

        check_klasses.each do |check_klass|
          ActiveRecord::Migrator.current_version check_klass.connection
        end
      rescue StandardError => e
        raise DatabaseException, e.message
      end

      private

      def check_klasses(request)
        result = []
        if request && request.params[:database_check_classes]
          request.params[:database_check_classes].split(",").each do |klass_string|
            klass = klass_string.constantize
            result << klass
          end
        else
          result << ActiveRecord::Base
        end
        result
      end
    end
  end
end
