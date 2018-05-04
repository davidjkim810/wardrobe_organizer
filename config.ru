require './config/environment'


use Rack::MethodOverride
use ItemsController
use WardrobesController
use UsersController
run ApplicationController
