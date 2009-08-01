module ApplicationName; module Controllers

  class Main < Controller
    map '/'

    layout { |p,w|
      case p
        when 'index', 'about', 'login', 'register'
          'default'
        else
          nil
      end
    }

    helper :stack, :user

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
      redirect rs( :/ )
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
