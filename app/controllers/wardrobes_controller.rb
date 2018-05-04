class WardrobesController < ApplicationController

  get '/wardrobes' do
    if logged_in?
      erb :'/wardrobes/wardrobes'
    else
      redirect '/login'
    end
  end

  get '/wardrobes/new' do
    erb :'/wardrobes/new'
  end

  get '/wardrobes/:slug' do
    @wardrobe = Wardrobe.find_by_slug(params[:slug])

    erb :'/wardrobes/show'
  end

  post '/wardrobes/new' do

    wardrobe = Wardrobe.create(name: params[:name])
    current_user.wardrobes << wardrobe

    params[:category][:name].each do |category_name|
      if category_name != ""
        new_category = Category.create(name: category_name)
        wardrobe.categories << new_category
        wardrobe.save
      end
    end
    redirect "/wardrobes"
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
