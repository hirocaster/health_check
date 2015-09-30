module HealthCheck
  module Plugins
    class DatabaseException < StandardError; end

    class Database < Base
      def check!(request: nil)
        @check_klasses = []

        if request.params[:database_check_classes]
          request.params[:database_check_classes].split(",").each do |klass_string|
            klass = klass_string.constantize
            @check_klasses << klass
          end
        else
          @check_klasses << ActiveRecord::Base
        end

        super

        @check_klasses.each do |check_klass|
          ActiveRecord::Migrator.current_version check_klass.connection
        end
      rescue Exception => e
        raise DatabaseException, e.message
      end
    end
  end
end
