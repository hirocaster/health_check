module HealthCheck
  module Plugins
    class DatabaseException < StandardError; end

    class Database < Base

      def check!
        ActiveRecord::Migrator.current_version(ActiveRecord::Base.connection)
      rescue Exception => e
        raise DatabaseException.new(e.message)
      end

    end
  end
end
