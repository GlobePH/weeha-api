class User < ApplicationRecord
  after_create :authenticate

  has_many :active_relationships, class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :locations

  validates :first_name, :last_name, presence: true
  validates :mobile_number, :username, presence: true, uniqueness: true

  def confirm(code)
    auth = GlobeApi.new().auth(['9k65C5xRKpu4Rck7zyTRaxuGzk4oCx6j'], ['46fe4042ad490e6ef3f921d97cdaf051f7a3824c71aa3bf8305bc0fc8cd41384'])
    uri = "http://developer.globelabs.com.ph/oauth/confirm_authorization"
    number = mobile_number.split('')
    number.delete_at(0)
    number = number.join('')
    data = Net::HTTP.post_form(URI.parse(uri), {'access_token[app_id]' => '9k65C5xRKpu4Rck7zyTRaxuGzk4oCx6j', 'access_token[subscriber_num]' => number, 'access_token[confirmation_code]' => code})
    code = data.body.split('=')[2].split("\"").first
    access_token = auth.getAccessToken([code])

    update!(access_token: access_token.split('"').fourth, verified: true)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def pending_requests
    passive_relationships.where(status: 'pending')
  end

  def approved_requests
    passive_relationships.where(status: 'approved')
  end

private

  def authenticate
    uri = "http://developer.globelabs.com.ph/oauth/request_authorization"
    number = mobile_number.split('')
    number.delete_at(0)
    number = number.join('')
    data = Net::HTTP.post_form(URI.parse(uri), {'access_token[app_id]' => '9k65C5xRKpu4Rck7zyTRaxuGzk4oCx6j', 'access_token[subscriber_num]' => number})
  end

end
