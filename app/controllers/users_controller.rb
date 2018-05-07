
class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.create(username: username, nickname: params[:nickname], password: params[:password])

  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by_username(username)

    if User.all.include?(@user) && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end

    erb :'/users/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    if logged_in? && current_user.id == @user.id
      erb :'/users/show'
    elsif logged_in?
      redirect "/users/#{current_user.slug}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
