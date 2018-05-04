require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_password"
  end


end
