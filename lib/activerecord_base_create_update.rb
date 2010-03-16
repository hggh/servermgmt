class ActiveRecord::Base
  before_validation :_clean_strip
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

  def _clean_strip
    self.attributes.each_pair do |key, value|
      self[key] = value.strip if value.respond_to?('strip')
    end
  end
end
