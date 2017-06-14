class FotonsController < ApplicationController

  def show
    @fotons = Foton.all
  end
end
