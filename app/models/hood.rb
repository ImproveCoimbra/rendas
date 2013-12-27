class Hood
  include Mongoid::Document
  field :name, type: String
  field :lat, type: Float
  field :lng, type: Float
  field :radius, type: Float
end
