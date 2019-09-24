require_relative("../db/sql_runner")

class Booking

  attr_reader :id
  attr_accessor :gym_class_id, :member_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @gym_class_id = options['gym_class_id'].to_i
    @member_id = options['member_id'].to_i
  end

  def save()
    sql = "INSERT INTO bookings (gym_class_id, member_id) VALUES ($1, $2) RETURNING id"
    values = [@gym_class_id, @member_id]
    booking = SqlRunner.run(sql, values).first;
    @id = booking['id'].to_i
  end

  def update()
    sql = "UPDATE bookings SET (gym_class_id, member_id) = ($1, $2) WHERE id = $3"
    values = [@gym_class_id, @member_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM bookings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def gym_class()
    sql = "SELECT * FROM gym_classes WHERE id = $1"
    values = [@gym_class_id]
    gym_class = SqlRunner.run(sql, values).first
    return GymClass.new(gym_class)
  end

  def member()
    sql = "SELECT * FROM members WHERE id = $1"
    values = [@member_id]
    member = SqlRunner.run(sql, values).first
    return Member.new(member)
  end

  def can_book()
    member = Member.find(@member_id)
    gym_class = GymClass.find(@gym_class_id)
    if !member.premium_membership && gym_class.premium_time_slot_check
      return false
    else
      return true
    end
  end

  def self.find(id)
    sql = "SELECT *
    FROM bookings
    WHERE id = $1"
    values = [id]
    bookings = SqlRunner.run(sql, values)
    return Booking.new(bookings.first())
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    bookings = SqlRunner.run(sql)
    return bookings.map{|booking| Booking.new(booking)}
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

end
