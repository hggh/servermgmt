Facter.add("vlans") do
  vlanconfig = '/proc/net/vlan/config'
  vlans = Array.new
  setcode do
    if File.exists?(vlanconfig)      
      File.open(vlanconfig).each do |line|
        if line =~ /^([0-9A-Za-z]+)\.([0-9]+) /
          vlans.insert(-1, $~[2]) if $~[2]
        end
      end
    end
    vlans.join(',')
  end
end
