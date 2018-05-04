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


end
