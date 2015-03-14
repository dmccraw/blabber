class BlabsController < ApplicationController
  def index
    @blabs = Blab.all
    render json: @blabs
  end
end
