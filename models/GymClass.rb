require_relative("../db/sql_runner")

class GymClass

  attr_reader :id
  attr_accessor :name, :capacity, :time_slot

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @capacity = options['capacity'].to_i
    @time_slot = options['time_slot']
  end

  def save()
    sql = "INSERT INTO gym_classes (name, capacity, time_slot) VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @capacity, @time_slot]
    gym_class = SqlRunner.run(sql, values).first()
    @id = gym_class['id'].to_i
  end

  def update()
    sql = "UPDATE gym_classes SET (name, capacity, time_slot) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @capacity, @time_slot, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM gym_classes where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON members.id = bookings.member_id WHERE gym_class_id = $1"
    values = [@id]
    members = SqlRunner.run(sql, values)
    return members.map {|member| Member.new(member)}
  end

  def premium_time_slot_check()
    return @time_slot == '07:00-08:00' || @time_slot == '08:00-09:00' || @time_slot == '17:00-18:00' || @time_slot == '18:00-19:00' || @time_slot == '19:00-20:00'
  end

  def self.all()
    sql = "SELECT * FROM gym_classes"
    gym_classes = SqlRunner.run(sql)
    return gym_classes.map {|gym_class| GymClass.new(gym_class)}
  end

  def self.delete_all()
    sql = "DELETE FROM gym_classes"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT *
    FROM gym_classes
    WHERE id = $1"
    values = [id]
    gym_classes = SqlRunner.run(sql, values)
    return GymClass.new(gym_classes.first())
  end

end
