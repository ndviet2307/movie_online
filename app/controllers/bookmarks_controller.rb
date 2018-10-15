class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_movies = current_user.bookmark_movies.sort_by_bookmark_desc
                                     .page(params[:page])
                                     .per Settings.movies_controller.per_page
  end

  def create
    movie = Movie.find_by id: params[:movie_id]

    if current_user.bookmark_movies.include? movie
      current_user.bookmark_movies.destroy movie
    else
      current_user.bookmark_movies << movie
    end

    redirect_back fallback_location: root_path
  end
end
