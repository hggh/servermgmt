class ParamValue < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  belongs_to :param_name
  belongs_to :resource
end
