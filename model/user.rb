module ApplicationName; module Models

  class User < DBI::Model( :users )

    def self.authenticate( credentials )
      return nil  if credentials.nil? || credentials.empty?

      if credentials[ :api_key ]
        self[ :api_key => credentials[ :api_key ] ]
      elsif credentials[ :openid ]
        self[ :openid => credentials[ :openid ] ]
      elsif credentials[ :password ]
        encrypted_password = Digest::SHA1.hexdigest( credentials[ :password ] )
        self[
          :username => credentials[ :username ],
          :encrypted_password => encrypted_password
        ]
      end
    end

    def self.register( username, password )
      encrypted_password = Digest::SHA1.hexdigest( password )
      self.create( username: username, encrypted_password: encrypted_password )
    end

    def to_s
      username || openid
    end

    def admin?
      admin
    end

  end

end; end