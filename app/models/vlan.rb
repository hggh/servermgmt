class Vlan < ActiveRecord::Base
  validates_uniqueness_of :name


  def self.create_or_update(options = {})
    id = options.delete(:id)
    record = find_by_id(id) || new
    record.id = id
    record.attributes = options
    record.save!

    record
  end
end
