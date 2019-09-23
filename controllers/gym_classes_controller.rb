require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/GymClass.rb' )
also_reload( '../models/*' )

get '/classes' do
  @classes = GymClass.all()
  erb(:classes)
end
