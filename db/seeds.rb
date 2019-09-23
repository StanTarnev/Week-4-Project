require_relative( "../models/member.rb" )
require_relative( "../models/gym_class.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

gym_class1 = ({
  'name' => 'Spinning'
  'capacity' => 4,
  'time_slot' => '5-6pm'
  })

gym_class2 = ({
  'name' => 'Boot Camp'
  'capacity' => 5,
  'time_slot' => '6-7pm'
  })

gym_class3 = ({
  'name' => 'Zumba'
  'capacity' => 6,
  'time_slot' => '10-11am'
  })

gym_class4 = ({
  'name' => 'Cross Fit'
  'capacity' => 3,
  'time_slot' => '7-8pm'
  })

gym_class5 = ({
  'name' => 'Pilates'
  'capacity' => 7,
  'time_slot' => '11-12am'
  })

gym_class6 = ({
  'name' => 'Hatha Yoga'
  'capacity' => 4,
  'time_slot' => '9-10am'
  })

gym-gym_class1.save()
gym-gym_class2.save()
gym-gym_class3.save()
gym-gym_class4.save()
gym-gym_class5.save()
gym-gym_class6.save()

member1 = ({
  'name' => 'Jack Scannuzzi'
  'membership-type' => 'Premium'
  })

member2 = ({
  'name' => 'Jack Scannuzzi'
  'membership-type' => 'Premium'
  })

member3 = ({
  'name' => 'Dolores Nguen'
  'membership-type' => 'Basic'
  })

member4 = ({
  'name' => 'Ivana Gustavsson'
  'membership-type' => 'Premium'
  })

member5 = ({
  'name' => 'Yiao Sanchez'
  'membership-type' => 'Basic'
  })

member6 = ({
  'name' => 'Shaqeel Petrov'
  'membership-type' => 'Premium'
  })

member7 = ({
  'name' => 'Hassan Hoffmann'
  'membership-type' => 'Basic'
  })

member8 = ({
  'name' => 'Monique Nasarewa'
  'membership-type' => 'Premium'
  })

member9 = ({
  'name' => 'Dwight Schrute'
  'membership-type' => 'Basic'
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

booking1 ({
  'gym_class_id' => gym_class1.id
  'member_id' => member1.id
  })

booking2 ({
  'gym_class_id' => gym_class2.id
  'member_id' => member3.id
  })

booking3 ({
  'gym_class_id' => gym_class4.id
  'member_id' => member5.id
  })

booking4 ({
  'gym_class_id' => gym_class6.id
  'member_id' => member7.id
  })

booking5 ({
  'gym_class_id' => gym_class1.id
  'member_id' => member8.id
  })

booking6 ({
  'gym_class_id' => gym_class2.id
  'member_id' => member9.id
  })

booking7 ({
  'gym_class_id' => gym_class3.id
  'member_id' => member1.id
  })

booking8 ({
  'gym_class_id' => gym_class4.id
  'member_id' => member2.id
  })

booking9 ({
  'gym_class_id' => gym_class5.id
  'member_id' => member3.id
  })

binding.pry
nil
