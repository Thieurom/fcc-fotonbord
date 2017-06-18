class FotonsController < ApplicationController
  before_action :require_login, only: :create

  def show
    @fotons = Foton.all
  end

  def create
    @foton = current_user.fotons.create(foton_params)
    respond_to do |format|
      if @foton.persisted?
        format.html { redirect_to current_user.nickname, status: :created }
        if request.referer == root_url || request.referer == user_url(current_user.nickname)
          format.js { render status: :created }
        else
          format.js { render inline: '$(".freeze-overlay").remove();modal.dismiss();', status: :created }
        end
      else
        if @foton.errors.any?
          format.html { redirect_to current_user.nickname, status: :unprocessable_entity }
          format.js { render 'error_messages', status: :unprocessable_entity }
        else
          format.html { redirect_to current_user.nickname, status: :internal_server_error }
          format.js { head :internal_server_error }
        end
      end
    end
  end


  private

  def foton_params
    params.require(:foton).permit(:source, :caption)
  end
end
