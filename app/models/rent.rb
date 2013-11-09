class Rent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :price, :type => Integer
  field :postal_code
  field :typology

  TYPOLOGIES = %w{Quarto T0 T1 T2 T3 T4+}

  validates :price, :presence => true
  validates :postal_code, :presence => true
  validates :typology, :presence => true, :inclusion => { :in => TYPOLOGIES, :allow_blank => true }

  belongs_to :postal_code

  default_scope includes(:postal_code)

  delegate :lat, :lng, :latitude, :longitude, :address, :county, :code, :to => :postal_code

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

end
