class Vote
  include Mongoid::Document

  field :type, type: Symbol
  field :username, type: String
  field :votedate, type: DateTime

  belongs_to :user
  embedded_in :tag
end