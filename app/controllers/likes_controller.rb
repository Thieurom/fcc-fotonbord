class LikesController < ApplicationController

  before_action :require_login
  before_action :get_foton

  def like
    unless @foton.nil?
      @like = @foton.likes.build(foton_id: @foton.id, user_id: current_user.id) 
      return head :ok if @like.save 
    end
    head :unprocessable_entity
  end

  def unlike
    if @foton.nil?
      head :unprocessable_entity
    else
      @like = @foton.likes.find_by(foton_id: @foton.id, user_id: current_user.id)
      @like.destroy
      head :ok
    end
  end


  private

  def get_foton
    @foton = Foton.find_by(id: params[:foton_id])
  end
end
