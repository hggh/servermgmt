# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091127235631) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ips", :force => true do |t|
    t.string   "ip",         :limit => nil
    t.integer  "network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iptype_id"
    t.integer  "server_id"
  end

  create_table "iptypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks", :force => true do |t|
    t.string   "network",     :limit => nil
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "servermacs", :force => true do |t|
    t.string   "comment"
    t.string   "mac",        :limit => nil
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serveroperationsystems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "config_preseed"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "comment"
    t.integer  "servertype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "serveroperationsystem_id"
  end

  create_table "servertypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
