
class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(params)

    if @user.save
      redirect '/login'
    elsif User.find_by(username: params[:username])
      flash[:message] = "** Username unavailable"
      redirect '/signup'
    else
      flash[:message] = "** Please fill out each field"
      redirect to '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by_username(params[:username])

    if User.all.include?(@user) && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/users/#{@user.slug}"
    end

    erb :'/users/login'
  end
  get '/users/:slug' do
    @users = User.find_by_slug(params[:slug])
      erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
