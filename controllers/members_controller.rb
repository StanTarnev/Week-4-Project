require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/Member.rb' )
also_reload( '../models/*' )
require('pry')

get '/members' do
  @members = Member.all()
  erb(:'members/index')
end

get '/members/new' do
  erb(:'members/new')
end

get '/members/:id' do
  all_gym_classes = GymClass.all()
  @current_member = Member.find(params[:id])

  gym_classes_with_available_places = []
  for gym_class in all_gym_classes
    if gym_class.capacity > gym_class.members.length
      gym_classes_with_available_places.push(gym_class)
    end
  end

  gym_classes_not_conflicting_in_time_slot = []
  for gym_class in gym_classes_with_available_places
    if @current_member.gym_classes.length > 0
      gym_classes_conflicting_in_time_slot = []
      @current_member.gym_classes.each do |current_member_gym_class|
        if current_member_gym_class.time_slot == gym_class.time_slot
          gym_classes_conflicting_in_time_slot.push(gym_class)
        end
      end
      if gym_classes_conflicting_in_time_slot.length < 1
        gym_classes_not_conflicting_in_time_slot.push(gym_class)
      end
    else
      gym_classes_not_conflicting_in_time_slot.push(gym_class)
    end
  end

  class_cannot_be_enrolled = []
  @gym_classes_not_conflicting = []
  for gym_class in gym_classes_not_conflicting_in_time_slot
    if gym_class.premium_time_slot_check && !@current_member.premium_membership
      class_cannot_be_enrolled.push(gym_class)
    else
      @gym_classes_not_conflicting.push(gym_class)
    end
  end

  erb(:'members/show')
end

post '/members' do
  if !params['premium_membership']
    params['premium_membership'] = false
  end
  new_member = Member.new(params)
  members = Member.all()
  name_in_list = false
  for member in members
    if member.name == new_member.name
      name_in_list = true
    end
  end
  if name_in_list
    erb(:'/members/create')
  else
    new_member.save()
    redirect to('/members')
  end
end

get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:'members/edit')
end

post '/members/:id' do
  if !params['premium_membership']
    params['premium_membership'] = false
  end
  updated_member = Member.new(params)
  members = Member.all()
  member_in_list = false
  for member in members
    if member.name == updated_member.name && member.premium_membership == updated_member.premium_membership
      member_in_list = true
    end
  end
  if member_in_list
    erb(:'/members/update')
  else
    updated_member.update()
    redirect to('/members')
  end
end

post '/members/:id/delete' do
  @member = Member.find(params[:id])
  @member.delete()
  redirect to('/members')
end

get '/members/:id/add_gym_class' do
  all_gym_classes = GymClass.all()
  @current_member = Member.find(params[:id])

  gym_classes_with_available_places = []
  for gym_class in all_gym_classes
    if gym_class.capacity > gym_class.members.length
      gym_classes_with_available_places.push(gym_class)
    end
  end

  gym_classes_not_conflicting_in_time_slot = []
  for gym_class in gym_classes_with_available_places
    if @current_member.gym_classes.length > 0
      gym_classes_conflicting_in_time_slot = []
      @current_member.gym_classes.each do |current_member_gym_class|
        if current_member_gym_class.time_slot == gym_class.time_slot
          gym_classes_conflicting_in_time_slot.push(gym_class)
        end
      end
      if gym_classes_conflicting_in_time_slot.length < 1
        gym_classes_not_conflicting_in_time_slot.push(gym_class)
      end
    else
      gym_classes_not_conflicting_in_time_slot.push(gym_class)
    end
  end

  class_cannot_be_enrolled = []
  @gym_classes_not_conflicting = []
  for gym_class in gym_classes_not_conflicting_in_time_slot
    if gym_class.premium_time_slot_check && !@current_member.premium_membership
      class_cannot_be_enrolled.push(gym_class)
    else
      @gym_classes_not_conflicting.push(gym_class)
    end
  end

  erb(:'members/add_gym_class')
end
