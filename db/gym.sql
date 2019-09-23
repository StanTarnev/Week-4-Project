DROP TABLE bookings;
DROP TABLE gym_classes;
DROP TABLE members;

CREATE TABLE gym_classes(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  capacity INT4,
  time_slot varchar(255)
);

CREATE TABLE members(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  membership_type VARCHAR(255)
);

CREATE TABLE bookings(
  id SERIAL4 PRIMARY KEY,
  gym_class_id INT4 REFERENCES gym_classes(id) ON DELETE CASCADE,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE
);
