class Rent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :price, :type => Integer
  field :postal_code
  field :address
  field :county
  field :lat, :type => Float
  field :lng, :type => Float
  field :typology

  alias :latitude  :lat
  alias :longitude :lng

  TYPOLOGIES = %w{Quarto T0 T1 T2 T3 T4+}

  validates :price, :presence => true
  validates :postal_code, :presence => true, :format => { :with => /\d{4}-\d{3}/, :allow_blank => true }
  validates :typology, :presence => true, :inclusion => { :in => TYPOLOGIES, :allow_blank => true }
  validate  :valid_postal_code

  before_create :fill_location

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  def postal_code_array
    if postal_code
      postal_code.split('-')
    else
      [nil,nil]
    end
  end

  def gmaps4rails_infowindow
    "#{price}&euro; (#{typology})"
  end

  private

  def valid_postal_code
    errors.add(:postal_code, 'doesn\'t exist') unless PostalCode.where(:postal_code => postal_code).any?
  end

  def fill_location
    results = PostalCode.where(:postal_code => postal_code)
    if results.any?
      pc = results.first
      self[:address] = pc.address
      self[:county] = pc.county
      pc.find_geo_location unless pc.has_geo_location?
      self[:lat] = pc.lat
      self[:lng] = pc.lng
    end
  end

end
