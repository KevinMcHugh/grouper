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

ActiveRecord::Schema.define(version: 20140130163413) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_people", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "person_id"
  end

  add_index "events_people", ["event_id"], name: "index_events_people_on_event_id"
  add_index "events_people", ["person_id"], name: "index_events_people_on_person_id"

  create_table "groups", force: true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["event_id"], name: "index_groups_on_event_id"

  create_table "groups_people", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  add_index "groups_people", ["group_id"], name: "index_groups_people_on_group_id"
  add_index "groups_people", ["person_id"], name: "index_groups_people_on_person_id"

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "gender"
    t.date     "start"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "team"
    t.string   "email_address"
    t.string   "uuid"
  end

end
