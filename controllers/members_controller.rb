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
  @member = Member.find(params[:id])
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
