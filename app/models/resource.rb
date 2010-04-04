class Resource < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  has_many :param_values, :dependent => :destroy
  has_many :param_names, :through => :param_values
  has_many :resource_tags, :dependent => :destroy
  belongs_to :host
end
