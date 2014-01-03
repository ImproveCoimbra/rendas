class Hood
  include Mongoid::Document
  field :name, type: String
  field :lat, type: Float
  field :lng, type: Float
  field :radius, type: Float

  def calculate_rents_difference
      # Find the postal codes inside the hood
      hood_radius_power = self.radius**2
      postal_codes_inside_hood = []
      PostalCode.all.each do |postal_code|
        distance = (postal_code.lat - self.lat) ** 2 + (postal_code.lng - self.lng) ** 2
        postal_codes_inside_hood << postal_code if distance < hood_radius_power
      end
      self[:num_postal_codes] = postal_codes_inside_hood.size
      # Find the rents for the postal codes inside the hood
      self[:rents] = Rent.where(:postal_code.in => postal_codes_inside_hood).to_a
      # Get the rents relative differences (in %) to the median of their typology
      rents_diff = self[:rents].map do |rent|
        median = Rent.median(rent.typology)
        (rent.price - median) / median * 100
      end
      self[:num_rents] = rents_diff.length
      # Find the median of the rents differences
      if self[:num_rents] > 0
        sorted = rents_diff.sort
        self[:rents_diff] = ((sorted[(self[:num_rents] - 1) / 2] + sorted[self[:num_rents] / 2]) / 2.0).round(2)
      else
        self[:rents_diff] = 0
      end
  end

end
