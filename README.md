This is a basic adapter for ActiveResource to (mostly) work with Devise.

1. Add this as a submodule or stick it somewhere that will be loaded by Rails
1. Set Devise to use this by requiring active_resource_model in configginitializers/devise.rb
1. Subclass your model from ActiveResource::Base & include any ActiveModel components you want to use
1. Figure out which methods to override...

Initially we found it necessary to over #save to set some of the attributes you want to pass along.
Here's an example with database_authenticable

    class User < ActiveResource::Base
      include ActiveModel::Validations
      include ActiveResource::Validations

      self.site = "http:g/localhost:9292"
      self.format = :json

      attr_accessor :encrypted_password, :password_salt

      devise :database_authenticable

      def save
        self.password = @attributes['password']

        # make sure encrypted password gets set
        raise "encrypted password not set" unless @encrypted_password
        @attributes['encrypted_password'] = @encrypted_password
        @attributes['password_salt'] = @password_salt

        # delete the keys you don't want to pass back
        @attributes.delete('password')
        @attributes.delete('password_confirmation')

        super

        # manually load the errors
        self.load_remote_errors(@remote_errors)
      end

      # override some of Devise's methods
      def active?
        super && special_condition_is_valid?
      end

      def special_condition_is_valid?
        false if @errors
      end

      def special_condition_is_not_valid
        @errors.full_messages
      end

      def inactive_message
        special_condition_is_valid? ? super : :special_condition_is_not_valid
      end
    end

That's about as far as we got, which was getting success messages & errors back from the remote server just like you'd expect from using ActiveRecord.

Copyright Jesse Cooke (not that I really care) and released under the MIT license.
