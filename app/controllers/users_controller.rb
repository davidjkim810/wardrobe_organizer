class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(params)
    binding.pry
    redirect '/login'
  end

  get '/login' do
    erb :'/users/login'
  end

end
