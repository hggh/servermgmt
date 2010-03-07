class Setting < ActiveRecord::Base
  validates_uniqueness_of :key
  
  before_destroy { raise "You can't destroy an Setting!" }
  
  def self.get(dbkey)
    @values = Setting.find_by_sql("SELECT value FROM settings WHERE key='#{dbkey}'")
    if @values and @values.count == 1
      return @values[0]['value']
    end
    # if no value at database is found, make an lookup to settings.yml and save default value at DB
    @available_settings = YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))
    if @available_settings[dbkey]
      Setting.create(:key => dbkey, :boolean => @available_settings[dbkey]['boolean'], :value => @available_settings[dbkey]['default'])
      return @available_settings[dbkey]['default']
    end
  end
end
