class Movie < ApplicationRecord
  has_many :categories_movies, dependent: :destroy
  has_many :categories, through: :categories_movies
  has_many :movies_people, dependent: :destroy
  has_many :actors,
    ->{where movies_people[:role].eq(Person.roles[:actor])},
    source: :person, through: :movies_people
  has_many :directors,
    ->{where movies_people[:role].eq(Person.roles[:director])},
    source: :person, through: :movies_people
  has_many :movies_users, dependent: :destroy
  has_many :bookmark_users, through: :movies_users, source: :user
  has_many :view_counts, dependent: :destroy
  has_many :episodes, dependent: :destroy
  enum movie_type: {features: 0, series: 1, hots: 2}

  scope :sort_by_bookmark_desc, ->{order movies_users[:created_at].desc}

  validates :name, presence: true,
    length: {maximum: Settings.movie.name.max_length}
  validates :alternative_name,
    length: {maximum: Settings.movie.alternative_name.max_length}
  validates :poster, presence: true

  delegate :size, to: :episodes, prefix: true
  delegate :size, to: :actors, prefix: true
  delegate :size, to: :directors, prefix: true

  def bookmarked? user
    bookmark_users.include? user
  end

  class << self
    def movies_users
      MoviesUser.arel_table
    end

    def movies_people
      MoviesPerson.arel_table
    end
  end
end
