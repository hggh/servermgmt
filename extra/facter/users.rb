Facter.add("users") do
  confine :kernel => %w{Linux FreeBSD OpenBSD}
  setcode do
    users = Array.new
    if File.executable?('/usr/bin/getent')
      if getent_output = %x{/usr/bin/getent passwd}
        getent_output.split("\n").each do |line|
          next if line =~ /^nobody/

          users << line.split(":")[0] if line.split(":")[2].to_i > 1000 or line.split(":")[2].to_i == 0
        end

        users.join(',')
      end
    end
  end
end
