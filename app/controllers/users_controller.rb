
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/login'
    end
    erb :'/users/create_user'
  end

  post '/signup' do

    #validates that all fields are filled in, that the username is not already taken

    if params[:username] == "" || params[:nickname] == "" || params[:password] == ""
      flash[:message] = "*All fields required"
      erb :'/users/create_user'
    elsif User.find_by(username: username) != nil
      flash[:message] = "*Username already exists"
      erb :'/users/create_user'
    else
      User.create(username: username, nickname: params[:nickname], password: params[:password])
      erb :'/users/login'
    end

  end

  get '/login' do
    if logged_in?
      flash[:message] = "Log out in order to sign in as a different user"
      erb :index
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by_username(username)

    if params[:username] == "" || params[:password] == ""
      flash[:message] = "*Please enter username and password"
      erb :'/users/login'
    elsif !User.all.include?(@user)
      flash[:message] = "*Username does not exist"
      erb :'/users/login'
    elsif !@user.authenticate(params[:password])
      flash[:message] = "*Incorrect password"
      erb :'/users/login'
    elsif User.all.include?(@user) && @user.authenticate(params[:password])
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
