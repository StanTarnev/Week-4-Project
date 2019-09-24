require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/Booking.rb' )
also_reload( '../models/*' )

get '/bookings' do
  @bookings = Booking.all()
  erb(:'bookings/index')
end

get '/bookings/new' do
  @gym_classes = GymClass.all()
  @members = Member.all()
  # premium_booking()
  erb(:'bookings/new')
end

get '/bookings/:id' do
  @booking = Booking.find(params[:id])
  erb(:'bookings/show')
end

post '/bookings' do
  booking = Booking.new(params)
  @booking_successful = false
  if booking.can_book()
    booking.save()
    @booking_successful = true
  end
  erb(:'bookings/create')
end

get '/bookings/:id/edit' do
  @booking = Booking.find(params[:id])
  @gym_classes = GymClass.all()
  @members = Member.all()
  erb(:'bookings/edit')
end

post '/bookings/:id' do
  @booking = Booking.new(params)
  @booking.update()
  erb(:'bookings/update')
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete()
  erb(:'bookings/delete')
end
