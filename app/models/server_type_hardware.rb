class ServerTypeHardware < ActiveRecord::Base
  has_many :servertypes
  
  def self.create_or_update(options = {})
    id = options.delete(:id)
    record = find_by_id(id) || new
    record.id = id
    record.attributes = options
    record.save!
    
    record
  end

end
