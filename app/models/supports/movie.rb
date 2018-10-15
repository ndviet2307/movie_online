class Supports::Movie
  attr_reader :movie

  def initialize movie
    @movie ||= movie
  end

  def features
    @features ||= Movie.features
                       .limit Settings.movies_controller.number_movie
  end

  def series
    @series ||= Movie.series
                     .limit Settings.movies_controller.number_movie
  end

  def hots
    @hots ||= Movie.hots
                   .limit Settings.movies_controller.number_movie
  end
end
