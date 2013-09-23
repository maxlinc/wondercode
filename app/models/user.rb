class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable

  field :nickname
  field :email
  field :password
  field :token
  validates_presence_of :nickname, :password

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(nickname: data["nickname"]).first
      user
    else
      user = User.create!(nickname: data["nickname"], password: Devise.friendly_token[0,20])
    end

    user.token = access_token['credentials']['token']
    user.save
    user
  end

  def octokit
    octokit = Octokit::Client.new access_token: token
  end

  def repos
    octokit.repos nickname, type: 'owner'
  end
end