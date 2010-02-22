ServerTypeHardware.create_or_update(:id => 1, :name => "Hardware")
ServerTypeHardware.create_or_update(:id => 2, :name => "Virtual")
ServerTypeHardware.create_or_update(:id => 3, :name => "Domain0")

User.create_or_update(:id => 1, :username => 'admin', :password => 'admin', :password_confirmation => 'admin', :active => 1)

