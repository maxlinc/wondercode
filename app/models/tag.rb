class Tag
  include Mongoid::Document

  field :name, type: String

  embedded_in :repository
  embeds_many :votes
end