# coding: utf-8

class Rent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :price, :type => Integer
  field :typology

  TYPOLOGIES = %w{Quarto T0 T1 T2 T3 T4+}

  validates :price, :presence => { :message => 'Preço inválido' },
                    :numericality => { :only_integer => true, :greater_than => 5000, :less_than => 2000000, :message => 'Preço inválido' }
  validates :postal_code, :presence => { :message => 'Código-postal de Coimbra inválido' }
  validates :typology, :presence => { :message => 'Tipologia inválida' },
                       :inclusion => { :in => TYPOLOGIES, :allow_blank => true, :message => 'Tipologia inválida' }

  belongs_to :postal_code

  index({ :typology => 1 }, { :background => true })
  index({ :postal_code_id => 1 }, { :background => true })

  default_scope includes(:postal_code)

  delegate :lat, :lng, :address, :county, :code, :to => :postal_code

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  def latitude
    lat + (rand-0.5)/5000 # Nudge to avoid map pin overlaps
  end

  def longitude
    lng + (rand-0.5)/5000 # Nudge to avoid map pin overlaps
  end

  def price
    (self[:price].to_f / 100).round(2) if self[:price]
  end

  def self.typology_count(typology)
    where(:typology => typology).count
  end

  def self.median(typology)
    get_all_medians[typology]
  end

  def self.get_all_medians
    unless RequestStore.store[:rent_medians]
      medians = {}
      TYPOLOGIES.each do |t|
        medians[t] = begin
          prices = unscoped.where(:typology => t).map(&:price)
          unless prices.empty?
            sorted = prices.sort
            len = sorted.length
            ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).round(2)
          else
            nil
          end
        end
      end
      RequestStore.store[:rent_medians] = medians
    end
    RequestStore.store[:rent_medians]
  end

  def price=(new_price)
    price_will_change!
    self[:price] = (new_price.to_f * 100).to_i
  end

  def postal_code_array
    if postal_code
      code.split('-')
    else
      [nil,nil]
    end
  end

  def gmaps4rails_infowindow
    "%i&euro; (%s)<br/>%s<br/>%s" % [price, typology, address, code]
  end

  def gmaps4rails_marker_picture
    result = {
      :width => 12,
      :height => 12
    }
    median = Rent.median(typology)
    if median*1.1 < price
      image_name = 'dot-red.png'
    elsif median*0.9 > price
      image_name = 'dot-green.png'
    else
      image_name = 'dot-yellow.png'
    end
    result[:picture] = ActionController::Base.new.view_context.asset_path(image_name)
    result
  end

end
