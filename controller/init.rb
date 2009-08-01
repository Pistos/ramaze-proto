# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers

module ApplicationName
  class Controller < Ramaze::Controller
    layout :default
    helper :xhtml
    engine :Etanni
    provide( :json, :type => 'application/json' ) { |action, value| value.to_json }

    trait :user_model => ApplicationName::Models::User
  end
end

# Here go your requires for subclasses of Controller:
require __DIR__( 'main' )
