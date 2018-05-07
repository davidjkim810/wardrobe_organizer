class ItemsController < ApplicationController

  get '/items/new/:slug' do
    @wardrobe = Wardrobe.find_by_slug(params[:slug])

    erb :'/items/new'
  end

  post '/items/new' do
    @wardrobe = Wardrobe.find(Category.find_by(name: params[:category][:name]).wardrobe_id)

  end

end
