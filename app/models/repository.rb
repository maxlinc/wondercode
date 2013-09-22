class Repository
  include Mongoid::Document

  field :name, type: String
  field :login, type: String
  field :repo_url, type: String
  field :avatar_url, type: String
  field :languages, type: Array
  field :tags, type: Array
  field :url, type: String
  
  has_and_belongs_to_many :tags
end
