class ServerObserver < ActiveRecord::Observer
  observe :server

  def after_save(server)
    server_groups = ServerGroup.where("group_regex != ''")
    server_groups.each do |sg|
      reg = Regexp.new(sg.group_regex)
      if reg.match(server.fqdn)
        if ServerGroupMember.where(:server_id => server.id).where(:server_group_id => sg.id).count() == 0 
          sgm = ServerGroupMember.new(:server_id => server.id, :server_group_id => sg.id, :auto_add => true)
          sgm.save
        else
        end 
          
      else
        # delete server from group only if it was auto added!
        sgm = ServerGroupMember.where(:server_id => server.id).where(:server_group_id => sg.id).where(:auto_add => true).limit(1)[0]
        if sgm
          sgm.destroy
        end
      end
    end
  end

end