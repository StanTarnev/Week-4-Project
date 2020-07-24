require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/GymClass.rb' )
require_relative( '../helpers/member_filter.rb' )
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
  all_members = Member.all()
  @current_gym_class = GymClass.find(params[:id])
  @members_passing_requirements_for_time_slot = MemberFilter.filter_out_conflicting_members(all_members, @current_gym_class)

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
  pre_update_gym_class = GymClass.find(params[:id])
  updated_gym_class = GymClass.new(params)
  gym_classes = GymClass.all()

  @gym_class_already_listed = false
  for gym_class in gym_classes
    if gym_class.name == updated_gym_class.name && gym_class.time_slot == updated_gym_class.time_slot
      @gym_class_already_listed = true
    end
  end

  gym_class_booked = false
  if pre_update_gym_class.members.length > 0
    gym_class_booked = true
  end

  @capacity_too_low = false
  if updated_gym_class.capacity < pre_update_gym_class.members.length
    @capacity_too_low = true
  end

  @name_or_time_slot_changed = false
  if updated_gym_class.name != pre_update_gym_class.name || updated_gym_class.time_slot != pre_update_gym_class.time_slot
    @name_or_time_slot_changed = true
  end

  capacity_changed = false
  if updated_gym_class.capacity != pre_update_gym_class.capacity
    capacity_changed = true
  end

  update_possible = false
  if gym_class_booked
    if !@capacity_too_low && !@name_or_time_slot_changed
      update_possible = true
    end
  else
    if !@gym_class_already_listed
      update_possible = true
    else
      if !@name_or_time_slot_changed && capacity_changed
        update_possible = true
      end
    end
  end

  if update_possible
    updated_gym_class.update()
    redirect to('/gym_classes')
  else
    erb(:'/gym_classes/update')
  end
end

post '/gym_classes/:id/delete' do
  @gym_class = GymClass.find(params[:id])
  @gym_class.delete()
  redirect to('/gym_classes')
end

get '/gym_classes/:id/add_member' do
  all_members = Member.all()
  @current_gym_class = GymClass.find(params[:id])
  @members_passing_requirements_for_time_slot = MemberFilter.filter_out_conflicting_members(all_members, @current_gym_class)

  erb(:'gym_classes/add_member')
end
