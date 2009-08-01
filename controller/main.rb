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

    def index
      @title = "Home"
      if ! logged_in?
        redirect rs( :about )
      end
    end

  end

end; end