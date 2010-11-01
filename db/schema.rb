# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "logrows", :force => true do |t|
    t.integer  "userlogbook_id"
    t.integer  "instr_appr"
    t.integer  "landings"
    t.date     "flt_date"
    t.string   "make_model"
    t.string   "aircraft_ident"
    t.string   "from"
    t.string   "dest"
    t.string   "remarks"
    t.float    "sel"
    t.float    "mel"
    t.float    "xc"
    t.float    "pic_xc"
    t.float    "day"
    t.float    "night"
    t.float    "actual_ifr"
    t.float    "sim_ifr"
    t.float    "dual"
    t.float    "pic"
    t.float    "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"

  create_table "userlogbooks", :force => true do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "student_num"
    t.string   "ppl_num"
    t.date     "dob"
    t.date     "last_medical"
    t.date     "last_bfr"
    t.date     "last_ipc"
    t.date     "last_pic"
    t.date     "last_night"
    t.text     "address"
    t.text     "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
