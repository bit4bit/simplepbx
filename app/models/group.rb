class Group < ApplicationRecord
  include Routable
  routable_freeswitch_ref [:endpoint, :freeswitch, :id]
  
  belongs_to :endpoint
  has_many :extension_groups
  has_many :extensions, through: :extension_groups

  validates :name, presence: true, name: true
  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}

  def to_s
    name
  end
  def routable_name
    "Group(#{name})"
  end
  
  before_create do
    self.uuid = SecureRandom.uuid
  end

end
