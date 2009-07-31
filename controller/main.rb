module ApplicationName; module Controllers

  class Main < Controller
    map '/'

    def index
      @title = "Welcome to Ramaze!"
    end
  end

end; end