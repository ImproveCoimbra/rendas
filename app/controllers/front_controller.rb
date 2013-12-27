# encoding: UTF-8

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
    @median = Rent.median(@rent.typology)
  end

  def stats

    @hoods = Hood.all.to_a

    @hoods.each do |hood|
      # Find the postal codes inside the hood
      hood_radius_power = hood[:radius]**2
      postal_codes_inside_hood = []
      PostalCode.all.each do |postal_code|
        distance = (postal_code.lat - hood.lat) ** 2 + (postal_code.lng - hood.lng) ** 2
        postal_codes_inside_hood << postal_code if distance < hood_radius_power
      end
      hood[:num_postal_codes] = postal_codes_inside_hood.size
      # Find the rents for the postal codes inside the hood
      hood[:rents] = Rent.where(:postal_code.in => postal_codes_inside_hood).to_a
      # Get the rents relative differences (in %) to the median of their typology
      rents_diff = hood[:rents].map do |rent|
        median = Rent.median(rent.typology)
        (rent.price - median) / median * 100
      end
      hood[:num_rents] = rents_diff.length
      # Find the median of the rents differences
      sorted = rents_diff.sort
      hood[:rents_diff] = ((sorted[(hood[:num_rents] - 1) / 2] + sorted[hood[:num_rents] / 2]) / 2.0).round(2)
    end

    # Hoods with most rents first
    @hoods.sort! { |a,b| b[:num_rents] <=> a[:num_rents] }

  end

  def about; end

end
