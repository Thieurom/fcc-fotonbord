class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname]) or record_not_found
  end
end
