class ApplicationController < ActionController::Base
  before_action :new_foton
  protect_from_forgery with: :exception
  include SessionsHelper
  include LikesHelper

  private

  def record_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  def new_foton
    @foton = current_user.fotons.build if logged_in?
  end

  def require_login
    unless logged_in?
      redirect_to root_url
    end
  end
end
