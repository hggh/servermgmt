require 'ipaddr'
class ServerManager
  def is_ipaddress ip
    begin
      net = IPAddr.new ip
      if net.ipv4? or net.ipv6?
        return true
      else
      end
    rescue 
      return false
    end
    return false
  end

  def is_ipv4? ip
    begin
      net = IPAddr.new ip
      if net.ipv4?
        return true
      end
    rescue
      false
    end
    false
  end

  def is_ipv6? ip
    begin
      net = IPAddr.new ip
      if net.ipv6?
        return true
      end
    rescue
      false
    end
    false
  end

  def is_network network
    begin
      net = IPAddr.new network
      if net
        return true
      end
    rescue
      return false
    end
    false
  end
end

