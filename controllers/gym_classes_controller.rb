require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/GymClass.rb' )
also_reload( '../models/*' )
require('pry')

get '/gym_classes' do
  @gym_classes = GymClass.all()
  erb(:'gym_classes/index')
end

get '/gym_classes/new' do
  erb(:'gym_classes/new')
end

get '/gym_classes/:id' do
  @gym_class = GymClass.find(params[:id])
  erb(:'gym_classes/show')
end

post '/gym_classes' do
  @gym_class = GymClass.new(params)
  @gym_class.save()
  redirect to('/gym_classes')
end

get '/gym_classes/:id/edit' do
  @gym_class = GymClass.find(params[:id])
  erb(:'gym_classes/edit')
end

post '/gym_classes/:id' do
  @gym_class = GymClass.new(params)
  @gym_class.update()
  # erb(:'gym_classes/update')
  redirect to('/gym_classes')
end

post '/gym_classes/:id/delete' do
  @gym_class = GymClass.find(params[:id])
  @gym_class.delete()
  redirect to('/gym_classes')
end
