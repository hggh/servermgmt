class ParamName < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  has_many :param_values, :dependent => :destroy
end
