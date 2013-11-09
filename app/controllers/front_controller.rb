class FrontController < ApplicationController

  def index
    @rents = Rent.all
    @rent = Rent.new
  end

  def submit
    code = params[:rent].delete(:postal_code).values.join('-') if params[:rent] and params[:rent][:postal_code]
    @rent = Rent.new(params[:rent])
    @rent.postal_code = PostalCode.where(:code => code).first
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
