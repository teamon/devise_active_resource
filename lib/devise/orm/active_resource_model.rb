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
      module Schema
        include Devise::Schema

        def apply_devise_schema(name, type, options={})
          begin
            schema do
              attribute name, type.to_s.downcase.to_sym
            end
          rescue Exception => e
            puts "Hmm: #{e.message}"
          end
        end
      end
    end
  end
end

ActiveResource::Base.extend Devise::Models
ActiveResource::Base.extend Devise::Orm::ActiveResource::Hook
