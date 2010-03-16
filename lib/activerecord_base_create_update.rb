class ActiveRecord::Base
  def self.create_or_update(options = {})
    id = options.delete(:id)
    record = find_by_id(id) || new
    record.id = id
    record.attributes = options
    record.save!
    
    record
  end

  def self.create_or_update_byname(options = {})
    name = options.delete(:name)
    record = find_by_name(name) || new
    record.name = name
    record.attributes = options
    record.save!

    record
  end
end