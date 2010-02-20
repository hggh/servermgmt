ServerTypeHardware.delete_all
ServerTypeHardware.create(:id => 1, :name => "Hardware")
ServerTypeHardware.create(:id => 2, :name => "Virtual")
ServerTypeHardware.create(:id => 3, :name => "Domain0")

User.delete_all
User.create(:id => 1, :username => 'admin', :password => 'admin', :password_confirmation => 'admin', :active => 1)

