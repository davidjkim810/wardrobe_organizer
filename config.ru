require_relative './config/environment'


use Rack::MethodOverride
use ItemsController
use WardRobesController
use UsersController
run ApplicationController
