# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110521180300) do

  create_table "domain_nameservers", :force => true do |t|
    t.integer  "nameserver_id"
    t.integer  "domain_id"
    t.boolean  "primary_ns"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ns_entry",      :limit => 2, :default => 0, :null => false
  end

  create_table "domain_option_values", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "domain_option_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domain_options", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domain_record_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "extra_value", :default => false
  end

  create_table "domain_records", :force => true do |t|
    t.integer  "ttl"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "domain_record_type_id"
    t.string   "source"
    t.string   "value"
    t.string   "extra_value"
  end

  create_table "domain_soas", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "ttl"
    t.string   "primary_ns"
    t.string   "mail"
    t.integer  "refresh"
    t.integer  "retry"
    t.integer  "expire"
    t.integer  "negative_ttl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.integer  "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interface_options", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interfaces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ip_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ips", :force => true do |t|
    t.integer  "network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ip_type_id"
    t.integer  "server_id"
    t.integer  "is_primary"
    t.string   "ip",         :limit => nil
  end

  create_table "nameservers", :force => true do |t|
    t.string   "name"
    t.string   "ip",               :limit => nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mcollective_host", :limit => 100
  end

  create_table "networks", :force => true do |t|
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gw",         :limit => nil
    t.string   "network",    :limit => nil
  end

  create_table "server_group_members", :force => true do |t|
    t.integer  "server_group_id"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "auto_add",        :default => false
  end

  create_table "server_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "group_regex"
  end

  create_table "server_interface_options", :force => true do |t|
    t.integer  "interface_option_id"
    t.integer  "server_interface_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_interfaces", :force => true do |t|
    t.integer  "server_id"
    t.integer  "interface_id"
    t.integer  "vlan_id"
    t.integer  "ip_id"
    t.boolean  "alias"
    t.boolean  "default_gw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_key_values", :force => true do |t|
    t.integer  "server_id"
    t.integer  "server_key_id"
    t.text     "kvalue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_keys", :force => true do |t|
    t.string   "ktype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_macs", :force => true do |t|
    t.string   "comment"
    t.string   "mac"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_operation_systems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "config_preseed"
  end

  create_table "server_virtuals", :force => true do |t|
    t.integer  "hardware_id"
    t.integer  "virtual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "comment"
    t.integer  "servertype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "server_operation_system_id"
    t.integer  "domain_id"
  end

  create_table "servertypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "boolean",    :default => 0
  end

  create_table "sshkey_group_mbrs", :force => true do |t|
    t.integer  "sshkey_id"
    t.integer  "sshkey_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sshkey_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sshkeys", :force => true do |t|
    t.string   "name"
    t.text     "key_public"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sshuser_mbrs", :force => true do |t|
    t.integer  "sshuser_id"
    t.integer  "sshkey_id"
    t.integer  "sshkey_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sshusers", :force => true do |t|
    t.string   "username"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "server_group_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "passwd"
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secret_key"
  end

  create_table "vlans", :force => true do |t|
    t.string   "name",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
