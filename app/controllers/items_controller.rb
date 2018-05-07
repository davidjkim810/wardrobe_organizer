class ItemsController < ApplicationController

  get '/items/new/:id' do

    @wardrobe = Wardrobe.find_by(id: params[:id])

    erb :'/items/new'
  end

  post '/items/new' do

    @wardrobe = Wardrobe.find(Category.find(params[:category][:id]).wardrobe.id)

    if params[:name] == "" || params[:brand] == ""
      flash[:message] = "Your item must have a name and brand."
      erb :'/items/new'
    else
      new_item = Item.create(name: params[:name], category_id: params[:category][:id], wardrobe_id: @wardrobe.id)

      if Brand.find_by(name: params[:brand]) != nil
        brand = Brand.find_by(name: params[:brand])
        brand.items << new_item
      elsif Brand.find_by(name: params[:brand]) == nil
        brand = Brand.create(name: params[:brand])
        brand.items << new_item
      end
      redirect "/wardrobes/#{@wardrobe.id}"
    end
  end

  delete '/items/:id/delete' do
    item = Item.find(params[:id])
    wardrobe = Wardrobe.find(item.wardrobe.id)

    flash[:message] = "***Successfully deleted #{item.name}"
    binding.pry
    redirect "/wardrobes/#{wardrobe.id}"
  end

end
