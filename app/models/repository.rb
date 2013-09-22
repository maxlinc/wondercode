class Repository
  include Mongoid::Document

  field :name, type: String
  field :login, type: String
  field :repo_url, type: String
  field :avatar_url, type: String
  field :languages, type: Array
  field :url, type: String
  field :positive_vote_count, type: Integer, default: 0
  field :negative_vote_count, type: Integer, default: 0

  embeds_many :tags

  def fullname
    "#{login}/#{name}"
  end
end
