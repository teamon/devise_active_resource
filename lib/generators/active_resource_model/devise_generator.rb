require 'generators/devise/orm_helpers'

module ActiveResource
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      include Devise::Generators::OrmHelpers

      def generate_model
        invoke "resource", [name] unless model_exists?
      end

      def inject_devise_content
        inject_into_file model_path, model_contents, :after => "ActiveResource::Base\n"
      end
    end
      
  end
    
end
