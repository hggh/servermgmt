class ServerKey < ActiveRecord::Base
  has_many :server_key_values
  has_many :servers, :through => :server_key_values

  validates_presence_of :ktype
end
