class Person < ApplicationRecord
  enum role: {actor: 0, director: 1}

  has_many :movies_people
  has_many :movies, through: :movies_people
  has_many :cast_movies,
    ->{where movies_people[:role].eq(Person.roles[:actor])},
    source: :movie, through: :movies_people
  has_many :direct_movies,
    ->{where movies_people[:role].eq(Person.roles[:director])},
    source: :movie, through: :movies_people

  validates :name, presence: true,
    length: {minimum: Settings.person.name.min_length,
             maximum: Settings.person.name.max_length}

  class << self
    def movies_people
      MoviesPerson.arel_table
    end
  end
end
