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

  get '/wardrobes/:slug' do

    if logged_in?
      @wardrobe = Wardrobe.find_by_slug(params[:slug])
      erb :'/wardrobes/show'
    else
      flash[:message] = "*You must log in to view this page"
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
        if category_name != "" && Category.find_by(name: category_name) != nil
          flash[:message] = "*You cannot have two of the same categories"
        elsif category_name != ""
          new_category = Category.create(name: category_name)
          wardrobe.categories << new_category
          wardrobe.save
        end
      end

      redirect '/wardrobes'
    end
  end

  delete '/wardrobes/:id/delete' do
    wardrobe = Wardrobe.find(params[:id])
    if !logged_in?
      redirect '/'
    elsif logged_in? && wardrobe.user_id == current_user.id
      wardrobe = Wardrobe.find(params[:id])
      wardrobe.delete
      redirect '/wardrobes'
    end
  end



end
