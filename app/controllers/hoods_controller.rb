class HoodsController < ApplicationController
  before_filter :authenticate

  # GET /hoods
  # GET /hoods.json
  def index
    @hoods = Hood.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hoods }
    end
  end

  # GET /hoods/1
  # GET /hoods/1.json
  def show
    @hood = Hood.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hood }
    end
  end

  # GET /hoods/new
  # GET /hoods/new.json
  def new
    @hood = Hood.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hood }
    end
  end

  # GET /hoods/1/edit
  def edit
    @hood = Hood.find(params[:id])
  end

  # POST /hoods
  # POST /hoods.json
  def create
    @hood = Hood.new(params[:hood])

    respond_to do |format|
      if @hood.save
        format.html { redirect_to @hood, notice: 'Hood was successfully created.' }
        format.json { render json: @hood, status: :created, location: @hood }
      else
        format.html { render action: "new" }
        format.json { render json: @hood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hoods/1
  # PUT /hoods/1.json
  def update
    @hood = Hood.find(params[:id])

    respond_to do |format|
      if @hood.update_attributes(params[:hood])
        format.html { redirect_to @hood, notice: 'Hood was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hoods/1
  # DELETE /hoods/1.json
  def destroy
    @hood = Hood.find(params[:id])
    @hood.destroy

    respond_to do |format|
      format.html { redirect_to hoods_url }
      format.json { head :no_content }
    end
  end
end
