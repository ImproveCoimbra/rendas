class PostalCode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code
  field :address
  field :county
  field :lat, :type => Float
  field :lng, :type => Float

  has_many :rents

  index({:code => 1}, {:background => true})

  alias :latitude  :lat
  alias :longitude :lng

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  def to_s
    code
  end

  def gmaps4rails_infowindow
    code + " " + county + "<br/>" + address + "<br/> <a href=\"/postal_codes/#{id}\">Open</a>"
  end

  def has_geo_location?
    not lat.nil? and not lng.nil?
  end

  def full_address
    address + " " + county + " Portugal"
  end

  def find_geo_location
    results = Geocoder.search(full_address, :region => 'pt', :components => "country:PT|postal_code:#{code}|locality:Coimbra")
    if results.any?
      result = results.first
      self[:lat] = result.latitude
      self[:lng] = result.longitude
      save
    end
  end

end
