class ResourceTag < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  belongs_to :resource
end
