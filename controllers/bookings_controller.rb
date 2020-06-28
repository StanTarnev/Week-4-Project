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
  new_booking = Booking.new(params)
  @premium_membership = false
  if new_booking.can_book()
    @premium_membership = true
  end

  bookings = Booking.all()
  @member_already_booked_for_time_slot = false
  for booking in bookings
    if booking.member_id == new_booking.member_id && booking.gym_class.time_slot == new_booking.gym_class.time_slot
      @member_already_booked_for_time_slot = true
    end
  end

  if !@member_already_booked_for_time_slot && @premium_membership
    new_booking.save()
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
