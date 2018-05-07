class ItemsController < ApplicationController

  get '/items/new/:slug' do

    @wardrobe = Wardrobe.find_by_slug(params[:slug])

    erb :'/items/new'
  end

  post '/items/new' do

    @wardrobe = Wardrobe.find(Category.find_by(name: params[:category][:name]).wardrobe_id)

    if params[:name] == "" || params[:brand] == ""
      flash[:message] = "Your item must have a name and brand."
      erb :'/items/new'
    else
      new_item = Item.create(name: params[:name], category_id: Category.find_by(name: params[:category][:name]).id)

      if Brand.find_by(name: params[:brand]) != nil
        brand = Brand.find_by(name: params[:brand])
        brand.items << new_item
      elsif Brand.find_by(name: params[:brand]) == nil
        brand = Brand.create(name: params[:brand])
        brand.items << new_item
      end
      redirect '/wardrobes'
    end
  end

end
