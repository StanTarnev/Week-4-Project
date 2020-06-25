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
  @member = Member.new(params)
  @member.save()
  redirect to('/members')
end

get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:'members/edit')
end

post '/members/:id' do
  if !params['premium_membership']
    params['premium_membership'] = false
  end
  @member = Member.new(params)
  @member.update()
  redirect to('/members')
end

post '/members/:id/delete' do
  @member = Member.find(params[:id])
  @member.delete()
  redirect to('/members')
end
