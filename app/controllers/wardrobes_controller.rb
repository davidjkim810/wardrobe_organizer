class WardrobesController < ApplicationController

  get '/wardrobes' do

    if logged_in?
      erb :'/wardrobes/wardrobes'
    else
      flash[:message] = "*You must log in to view this page"
      erb :'/users/login'
    end
  end

  get '/wardrobes/new' do
    if logged_in?
      erb :'/wardrobes/new'
    else
      flash[:message] = "*You must log in to create a wardobe"
      erb :'/users/login'
    end
  end

  post '/wardrobes/new' do

    if params[:name] == ""
      flash[:message] = "*You must give your wardrobe a name"
      erb :'/wardrobes/new'
    else
      wardrobe = Wardrobe.create(name: params[:name])
      current_user.wardrobes << wardrobe

      params[:category][:name].each do |category_name|
        if category_name != ""
          category = Category.create(name: category_name)
          wardrobe.categories << category
        end
      end
      redirect '/wardrobes'
    end
  end

  get '/wardrobes/:id' do
    @wardrobe = Wardrobe.find_by(id: params[:id])
binding.pry
    if logged_in? && current_user.id == @wardrobe.user_id
      erb :'/wardrobes/show'
    elsif !logged_in?
        flash[:message] = "*You must log in to view this page"
      erb :'/users/login'
    elsif current_user.id != @wardrobe.user_id
      flash[:message] = "*Access Denied"
      erb :'/users/login'
    end
  end

  get '/wardrobes/edit/:id' do
    @wardrobe = Wardrobe.find_by(id: params[:id])

    if logged_in? && current_user.id == @wardrobe.user_id
      erb :'/wardrobes/edit'
    elsif current_user.id != @wardrobe.user_id
        flash[:message] = "*Access Denied"
      erb :'/users/login'
    elsif !logged_in?
        flash[:message] = "*You must log in to view this page"
      erb :'/users/login'
    end
  end

  patch '/wardrobes/edit/:id' do
    @wardrobe = Wardrobe.find_by(id: params[:id])

    if logged_in? && current_user.id == @wardrobe.user_id
      @wardrobe.name = params[:wardrobe][:name]
      @wardrobe.save

      if params[:name] != nil && params[:category][:name] != ""
        wardrobe_to_edit = @wardrobe.categories.find {|i| i.name == params[:name]}
        wardrobe_to_edit.name = params[:category][:name]
        wardrobe_to_edit.save
        @wardrobe.save
      end
      erb :'/wardrobes/show'
    elsif current_user.id != @wardrobe.user_id
        flash[:message] = "*Access Denied"
      erb :'/users/login'
    elsif !logged_in?
        flash[:message] = "*You must log in to view this page"
      erb :'/users/login'
    end
  end

  delete '/wardrobes/:id/delete' do
    wardrobe = Wardrobe.find(params[:id])

    if logged_in? && wardrobe.user_id == current_user
      wardrobe = Wardrobe.find(params[:id])
      wardrobe.delete
      redirect '/wardrobes'
    elsif current_user.id != @wardrobe.user_id
        flash[:message] = "*Access Denied"
      erb :'/users/login'
    elsif !logged_in?
        flash[:message] = "*You must log in to view this page"
      erb :'/users/login'
    end
  end
end
