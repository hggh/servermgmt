class Sshuser < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => { :scope => :server_id }
  validates :server_id, :presence => true
  belongs_to :server
end
