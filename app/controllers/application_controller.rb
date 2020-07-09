class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action(:set_favorites)

  def set_favorites
    @favorites = Favorites.new(session[:favorites])
  end
end
