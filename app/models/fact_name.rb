class FactName < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  has_many :fact_values, :dependent => :destroy
end
