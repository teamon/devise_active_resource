require 'devise_active_resource'

module Devise
  module Orm
    module ActiveResource
      module Hook
        def devise_modules_hook!
          extend Schema
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end
    end
  end
end

ActiveResource::Base.extend Devise::Models
ActiveResource::Base.extend Devise::Orm::ActiveResource::Hook
