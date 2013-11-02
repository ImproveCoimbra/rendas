class PostalCode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code
  field :address
  field :county
  field :lat, :type => Float
  field :lng, :type => Float

  index({:code => 1}, {:background => true})

  alias :latitude  :lat
  alias :longitude :lng

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_infowindow
    code + " " + county + "<br/>" + address
  end

  def has_geo_location?
    not lat.nil? and not lng.nil?
  end

  def full_address
    address + " " + county + " Portugal"
  end

  def find_geo_location
    results = Geocoder.search(full_address)
    if results.any?
      result = results.first
      self[:lat] = result.latitude
      self[:lng] = result.longitude
      save
    end
  end

end
