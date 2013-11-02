class FrontController < ApplicationController

  def index
    @rents = Rent.all
    @rent = Rent.new
  end

  def submit
    params[:rent][:postal_code] = params[:rent][:postal_code].values.join('-') if params[:rent]
    @rent = Rent.new(params[:rent])
    if @rent.save
      redirect_to :action => :index
    else
      @rents = Rent.all
      render :index
    end
  end

  def data
    render :json => Rent.all.to_json
  end

end
