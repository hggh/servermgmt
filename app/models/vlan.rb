class Vlan < ActiveRecord::Base
  default_scope :order => :id
  validates_uniqueness_of :name

end
