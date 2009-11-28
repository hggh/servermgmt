class Server < ActiveRecord::Base
  default_scope :order => :name
  validates_presence_of :name
  validates_length_of :name, :minimum => 5
  belongs_to :customer
  belongs_to :servertype
  belongs_to :serveroperationsystem
  has_many :ips, :dependent => :destroy
  has_many :servermacs, :dependent => :destroy
end
