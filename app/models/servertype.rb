class Servertype < ActiveRecord::Base
  validates_presence_of :name

  has_many :servers
end
