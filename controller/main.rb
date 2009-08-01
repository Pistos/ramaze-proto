module ApplicationName; module Controllers

  class Main < Controller
    map '/'

    layout { |p,w|
      case p
        when 'index', 'about', 'login', 'logout', 'openid', 'register'
          'default'
        else
          nil
      end
    }

    helper :stack, :user, :identity

    def register
      redirect_referrer  if logged_in?
      return  if ! request.post?

      username = request[ 'username' ]
      password = request[ 'password' ]
      u = Models::User[ username: username ]
      if u
        flash[ :error ] = "#{username} is already registered."
      else
        Models::User.register( username, password )
      end
      user_login( username: username, password: password )
      if logged_in?
        flash[ :success ] = "Registered #{username}."
        answer rs( :/ )
      else
        flash[ :error ] = "Failed to register #{username}."
      end
    end

    def login
      redirect_referrer  if logged_in?

      if request.post?
        user_login(
          :username => request[ 'username' ],
          :password => request[ 'password' ]
        )
        if logged_in?
          answer rs( :/ )
        end
      end
    end

    def logout
      user_logout
      session[ :openid ] = nil
      redirect rs( :/ )
    end

    def openid
      redirect_referrer  if logged_in?
      oid = session[ :openid ] ? session[ :openid ][ :identity ] : nil
      if oid
        user_login( :openid => oid )
        if ! logged_in?
          u = Models::User.create( :openid => oid )
          if u
            flash[ :success ] = "Created account with OpenID #{oid}."
            user_login( :openid => u.openid )
          else
            flash[ :error ] = "There is no account with the OpenID #{oid}; failed to create one."
          end
        else
          flash[ :success ] = "Logged in with OpenID."
          redirect_referrer
        end
      end
    end

    # -----------------------

    def index
      @title = "Home"
      if ! logged_in?
        redirect rs( :about )
      end
    end

  end

end; end
