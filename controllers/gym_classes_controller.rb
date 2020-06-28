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
  new_gym_class = GymClass.new(params)
  gym_classes = GymClass.all()
  gym_class_already_listed = false
  for gym_class in gym_classes
    if gym_class.name == new_gym_class.name && gym_class.time_slot == new_gym_class.time_slot
      gym_class_already_listed = true
    end
  end
  if gym_class_already_listed
    erb(:'/gym_classes/create')
  else
    new_gym_class.save()
    redirect to('/gym_classes')
  end
end

get '/gym_classes/:id/edit' do
  @gym_class = GymClass.find(params[:id])
  erb(:'gym_classes/edit')
end

post '/gym_classes/:id' do
  updated_gym_class = GymClass.new(params)
  gym_classes = GymClass.all()
  gym_class_already_listed = false
  for gym_class in gym_classes
    if gym_class.name == updated_gym_class.name && gym_class.time_slot == updated_gym_class.time_slot
      gym_class_already_listed = true
    end
  end
  if gym_class_already_listed
    erb(:'/gym_classes/update')
  else
    updated_gym_class.update()
    redirect to('/gym_classes')
  end
end

post '/gym_classes/:id/delete' do
  @gym_class = GymClass.find(params[:id])
  @gym_class.delete()
  redirect to('/gym_classes')
end
