# encoding: UTF-8

class FrontController < ApplicationController

  def index
    @num_rents = Rent.count
    @rent = Rent.new
  end

  def load
    @rents = Rent.all
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
    @median = Rent.median(@rent.typology)
  end

  def zonas
    @hoods = Hood.all.to_a
    @hoods.each(&:calculate_rents_difference)
    @hoods.sort! { |a,b| b[:rents_diff] <=> a[:rents_diff] }
  end

  def about; end

end
