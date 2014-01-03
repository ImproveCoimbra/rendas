class Hood
  include Mongoid::Document
  field :name,   :type => String
  field :lat,    :type => Float
  field :lng,    :type => Float
  field :radius, :type => Float
  field :diff,   :type => Float

  has_and_belongs_to_many :rents, :inverse_of => nil, :validate => false

  def num_rents
    self[:rent_ids] ? self[:rent_ids].size : 0
  end

  def calculate_rents_difference
    # Find the postal codes inside the hood
    hood_radius_power = self.radius**2
    postal_codes_inside_hood = []
    PostalCode.all.each do |postal_code|
      distance = (postal_code.lat - self.lat) ** 2 + (postal_code.lng - self.lng) ** 2
      postal_codes_inside_hood << postal_code if distance < hood_radius_power
    end
    # Find the rents for the postal codes inside the hood
    rents = Rent.where(:postal_code.in => postal_codes_inside_hood).to_a
    self[:rent_ids] = rents.map {|rent|rent.id}
    # Get the rents relative differences (in %) to the median of their typology
    rents_diff_list = rents.map do |rent|
      median = Rent.median(rent.typology)
      (rent.price - median) / median * 100
    end
    # Find the median of the rents differences
    if num_rents > 0
      sorted = rents_diff_list.sort
      self[:diff] = ((sorted[(num_rents - 1) / 2] + sorted[num_rents / 2]) / 2.0).round(2)
    else
      self[:diff] = 0
    end
  end

end
