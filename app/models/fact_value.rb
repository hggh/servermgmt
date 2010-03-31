class FactValue < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  belongs_to :fact_name
  belongs_to :host
  
  def to_label
      "#{self.fact_name.name}"
  end
end
