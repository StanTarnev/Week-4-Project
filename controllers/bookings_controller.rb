require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/Booking.rb' )
also_reload( '../models/*' )

get '/bookings' do
  @bookings = Booking.all()
  erb(:'bookings/index')
end

get '/bookings/new' do
  erb(:'bookings/new')
end

get '/bookings/:id' do
  @booking = Booking.find(params[:id])
  erb(:'bookings/show')
end

post '/bookings' do
  @booking = Booking.new(params)
  @booking.save()
  erb(:'bookings/create')
end

get '/bookings/:id/edit' do
  @booking = Booking.find(params[:id])
  erb(:'bookings/edit')
end

post 'bookings/:id' do
  @booking = Booking.new(params)
  @booking.update()
  erb(:'bookings/update')
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete()
  erb(:'bookings/delete')
end
