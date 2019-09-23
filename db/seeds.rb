require_relative( "../models/Member.rb" )
require_relative( "../models/GymClass.rb" )
require_relative( "../models/Booking.rb" )
require("pry-byebug")

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

gym_class1 = GymClass.new({
  'name' => 'Spinning',
  'capacity' => 4,
  'time_slot' => '5-6pm'
  })

gym_class2 = GymClass.new({
  'name' => 'Boot Camp',
  'capacity' => 5,
  'time_slot' => '6-7pm'
  })

gym_class3 = GymClass.new({
  'name' => 'Zumba',
  'capacity' => 6,
  'time_slot' => '10-11am'
  })

gym_class4 = GymClass.new({
  'name' => 'Cross Fit',
  'capacity' => 3,
  'time_slot' => '7-8pm'
  })

gym_class5 = GymClass.new({
  'name' => 'Pilates',
  'capacity' => 7,
  'time_slot' => '11-12am'
  })

gym_class6 = GymClass.new({
  'name' => 'Hatha Yoga',
  'capacity' => 4,
  'time_slot' => '9-10am'
  })

gym_class1.save()
gym_class2.save()
gym_class3.save()
gym_class4.save()
gym_class5.save()
gym_class6.save()

member1 = Member.new({
  'name' => 'Alejandra Monroe',
  'premium_membership' => false
  })

member2 = Member.new({
  'name' => 'Jack Scannuzzi',
  'premium_membership' => true
  })

member3 = Member.new({
  'name' => 'Dolores Nguen',
  'premium_membership' => false
  })

member4 = Member.new({
  'name' => 'Ivana Gustavsson',
  'premium_membership' => true
  })

member5 = Member.new({
  'name' => 'Yiao Sanchez',
  'premium_membership' => false
  })

member6 = Member.new({
  'name' => 'Shaqeel Petrov',
  'premium_membership' => true
  })

member7 = Member.new({
  'name' => 'Hassan Hoffmann',
  'premium_membership' => false
  })

member8 = Member.new({
  'name' => 'Monique Nasarewa',
  'premium_membership' => true
  })

member9 = Member.new({
  'name' => 'Dwight Schrute',
  'premium_membership' => false
  })

member1.save()
member2.save()
member3.save()
member4.save()
member5.save()
member6.save()
member7.save()
member8.save()
member9.save()

booking1 = Booking.new({
  'gym_class_id' => gym_class1.id,
  'member_id' => member1.id
  })

booking2 = Booking.new({
  'gym_class_id' => gym_class2.id,
  'member_id' => member3.id
  })

booking3 = Booking.new({
  'gym_class_id' => gym_class4.id,
  'member_id' => member5.id
  })

booking4 = Booking.new({
  'gym_class_id' => gym_class6.id,
  'member_id' => member7.id
  })

booking5 = Booking.new({
  'gym_class_id' => gym_class1.id,
  'member_id' => member8.id
  })

booking6 = Booking.new({
  'gym_class_id' => gym_class2.id,
  'member_id' => member9.id
  })

booking7 = Booking.new({
  'gym_class_id' => gym_class3.id,
  'member_id' => member1.id
  })

booking8 = Booking.new({
  'gym_class_id' => gym_class4.id,
  'member_id' => member2.id
  })

booking9 = Booking.new({
  'gym_class_id' => gym_class5.id,
  'member_id' => member3.id
  })

booking1.save()
booking2.save()
booking3.save()
booking4.save()
booking5.save()
booking6.save()
booking7.save()
booking8.save()
booking9.save()

binding.pry
nil
