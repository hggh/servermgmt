class ServerKeyValue < ActiveRecord::Base
  belongs_to :server
  belongs_to :server_key

  validates_presence_of :kvalue
  validates_presence_of :server_id
  validates_presence_of :server_key_id
  validates_associated :server
  validates_associated :server_key
end
