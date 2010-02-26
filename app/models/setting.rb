class Setting < ActiveRecord::Base
  validates_uniqueness_of :key
  
  before_destroy { raise "You can't destroy an Setting!" }
  
  def self.get(dbkey)
    @values = Setting.find_by_sql("SELECT value FROM settings WHERE key='#{dbkey}'")
    return @values[0]['value']
  end
end
