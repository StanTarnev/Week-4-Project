require_relative("../db/sql_runner")

class Member

  attr_reader :id
  attr_accessor :name, :membership_type

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @membership_type = options['membership_type']
  end

  def save()
    sql = "INSERT INTO members (name, membership_type)
          VALUES ($1, $2)
          RETURNING id"
    values = [@name, @membership_type]
    member = SqlRunner.run(sql, values).first
    @id = member['id'].to_i
  end

  def update()
    sql = "UPDATE members
          SET (name, membership_type) = ($1, $2)
          WHERE id = $3"
    values = [@name, @membership_type, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def gym_classes()
    sql = "SELECT gym_classes.*
          FROM gym_classes
          INNER JOIN bookings
          ON gym_classes.id = bookings.gym_class_id
          WHERE member_id = $1"
    values = [@id]
    gym_classes = SqlRunner.run(sql, values)
    return GymClass.map {|gym_class| GymClass.new(gym_class)}
  end

  def self.all()
    sql = "SELECT * FROM members"
    members = SqlRunner.run(sql)
    return Member.map {|member| Member.new(member)}
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT *
          FROM members
          WHERE id = $1"
    values = [id]
    members = SqlRunner.run(sql, values)
    return GymClass.new(members.first())
  end

end
