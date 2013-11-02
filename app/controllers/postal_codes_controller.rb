class PostalCodesController < ApplicationController
  # GET /postal_codes
  # GET /postal_codes.json
  def index
    @postal_codes = PostalCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postal_codes }
    end
  end

  # GET /postal_codes/1
  # GET /postal_codes/1.json
  def show
    @postal_code = PostalCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @postal_code }
    end
  end

  # GET /postal_codes/new
  # GET /postal_codes/new.json
  def new
    @postal_code = PostalCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @postal_code }
    end
  end

  # GET /postal_codes/1/edit
  def edit
    @postal_code = PostalCode.find(params[:id])
  end

  # POST /postal_codes
  # POST /postal_codes.json
  def create
    @postal_code = PostalCode.new(params[:postal_code])

    respond_to do |format|
      if @postal_code.save
        format.html { redirect_to @postal_code, notice: 'Postal code was successfully created.' }
        format.json { render json: @postal_code, status: :created, location: @postal_code }
      else
        format.html { render action: "new" }
        format.json { render json: @postal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /postal_codes/1
  # PUT /postal_codes/1.json
  def update
    @postal_code = PostalCode.find(params[:id])

    respond_to do |format|
      if @postal_code.update_attributes(params[:postal_code])
        format.html { redirect_to @postal_code, notice: 'Postal code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @postal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postal_codes/1
  # DELETE /postal_codes/1.json
  def destroy
    @postal_code = PostalCode.find(params[:id])
    @postal_code.destroy

    respond_to do |format|
      format.html { redirect_to postal_codes_url }
      format.json { head :no_content }
    end
  end

  def find_geo
    @postal_code = PostalCode.find(params[:id])
    @postal_code.find_geo_location
    redirect_to @postal_code
  end

end
