class Repository
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
end
