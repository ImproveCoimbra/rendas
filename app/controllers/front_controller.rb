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
      redirect_to :action => :result, :id => @rent
    else
      @rents = Rent.all
      render :index
    end
  end

  def result
    @rent = Rent.find(params[:id])
  end

  def about; end

end
