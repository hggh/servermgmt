class ServerVirtual < ActiveRecord::Base


  def self.getVirtuals(hw_id)
     ServerVirtual.find(:all, :conditions => "hardware_id = #{hw_id}")
 end
 def self.getHardware(vt_id)
   ServerVirtual.find(:all, :conditions => "virtual_id = #{vt_id}")
 end
end
