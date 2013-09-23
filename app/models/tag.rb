class Tag
  include Mongoid::Document
  field :name, type: String
  
  has_and_belongs_to_many :repositories

  def to_s
    name.gsub(/::/, '/')
  end

  def user
    name.split('::').first
  end

  def repo
    name.split('::').last
  end
end
