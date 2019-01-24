require_relative '../models/user.rb'
require_relative '../models/item.rb'

class ShoppingApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/items' do
    @items = Item.find_by(params[:filter])
    erb :"items/index"
  end

  get '/items/new' do
    erb :"items/new"
  end

  post '/items' do
    item = Item.new(params[:item])
    item.save
    redirect '/items'
  end

  delete '/items/:id' do
    Item.destroy(params[:id].to_i)
    redirect '/items'
  end

  get '/items/:location' do
    @location = params[:location]
    @items = Item.find_by(params[:filter])
    erb :"items/index"
  end

  get '/users' do
    @users = User.all
    erb :"users/index"
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = User.new(params[:user])
    user.save
    redirect '/users'
  end

  delete '/users/:id' do |id|
    User.destroy(id.to_i)
    redirect '/users'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :"users/show"
  end

end
