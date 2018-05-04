require 'bundler'
require_all 'app'

Bundler.require


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)
