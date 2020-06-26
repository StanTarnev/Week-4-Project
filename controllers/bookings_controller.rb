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
  if booking.can_book()
    booking.save()
    redirect to('/bookings')
  else
    erb(:'bookings/create')
  end
end

get '/bookings/:id/edit' do
  @booking = Booking.find(params[:id])
  @gym_classes = GymClass.all()
  @members = Member.all()
  erb(:'bookings/edit')
end

post '/bookings/:id' do
  @booking = Booking.new(params)
  if @booking.can_book()
    @booking.update()
    redirect to('/bookings')
  else
    erb(:'bookings/update')
  end
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete()
  redirect to('/bookings')
end
