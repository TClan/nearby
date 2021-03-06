# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170215063512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "driver_locations", force: :cascade do |t|
    t.integer   "driver_id"
    t.geography "latlong",       limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.decimal   "accuracy"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.datetime  "last_known_at"
  end

  add_index "driver_locations", ["driver_id"], name: "index_driver_locations_on_driver_id", using: :btree
  add_index "driver_locations", ["latlong"], name: "index_driver_locations_on_latlong", using: :gist

end
