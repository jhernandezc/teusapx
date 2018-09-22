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

ActiveRecord::Schema.define(version: 20180915042625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "TBL_RBARRIO", primary_key: "BAR_NID", id: :bigint, default: nil, force: :cascade do |t|
    t.string "BAR_CDESCRIPCION", limit: 150
    t.integer "LOC_NID", limit: 2
  end

  create_table "TBL_RCENTRO_TECNICO", primary_key: "CTEC_NID", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.string "CTEC_CDESCRIPCION", limit: 150
  end

  create_table "TBL_RLOCALIDAD", primary_key: "LOC_NID", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.string "LOC_CDESCRIPCION", limit: 100
  end

  create_table "TBL_RNORMA", primary_key: "NORM_NID", id: :bigint, default: nil, force: :cascade do |t|
    t.string "NORM_CDESCRIPCION", limit: 150
    t.bit "NORM_OESTADO", limit: 1
  end

  create_table "TBL_RPERFIL", primary_key: "PER_NID", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.string "PER_CDESCRIPCION", limit: 50
    t.bit "PER_OESTADO", limit: 1
  end

  create_table "TBL_RTIPO_VEHICULO", primary_key: "TIPV_NID", id: :integer, default: nil, force: :cascade, comment: "Maestro relacional de los tipos de vehiculos" do |t|
    t.boolean "TIPV_OESTADO", comment: "ESTADOS\r\n0= FALSE\r\n1= TRUE"
    t.text "TIPV_CDESCRIPCION"
  end

  create_table "TBL_RUSUARIOS", primary_key: "USU_NID", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.string "USU_CNOMAPELL", limit: 80
    t.string "USU_CTELEFONO", limit: 20
    t.bit "USU_OESTADO", limit: 1
    t.integer "PER_NID", limit: 2
  end

  create_table "TBL_TCAPACITACION", primary_key: "CAP_NID", id: :bigint, default: nil, force: :cascade do |t|
    t.date "CAP_DFECHA"
    t.integer "CAP_NETAPA"
    t.text "CAP_COBSERVACION"
    t.integer "CTEC_NID", limit: 2
  end

  create_table "TBL_TEVIDENCIA", primary_key: "EVID_NID", id: :bigint, default: nil, force: :cascade do |t|
    t.string "EVID_CRUTA_FILE", limit: 150
    t.bit "EVID_OESTADO", limit: 1
  end

  create_table "TBL_TINFRACION", primary_key: "INF_NID", id: :bigint, default: nil, force: :cascade, comment: "Encabezado de infraciones (transaccional)" do |t|
    t.date "INF_DFECHA"
    t.decimal "INF_NIDENTIFICACION"
    t.string "INF_CPLACA", limit: 10
    t.integer "TIPV_NID"
    t.integer "USU_NID"
    t.text "INF_COBSERVACION"
    t.integer "BAR_NID", limit: 2
  end

  create_table "TBL_TINFRACION_DET", primary_key: "DINF_NID", id: :bigint, default: nil, force: :cascade, comment: "Detalle de infracciones" do |t|
    t.bigint "INF_NID"
    t.bigint "NORM_NID"
    t.bit "DINF_OESTADO", limit: 1
  end

  create_table "TBL_UCAPACITACION_INFRACCION", id: false, force: :cascade do |t|
    t.bigint "CAP_NID"
    t.bigint "INF_NID"
  end

  create_table "TBL_UINFRACION_EVIDENCIA", id: false, force: :cascade do |t|
    t.bigint "INF_NID"
    t.bigint "EVID_NID"
  end

  create_table "tbl_rperfils", force: :cascade do |t|
    t.string "PER_NID"
    t.text "PER_CNAME"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tbl_rusuarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "TBL_RBARRIO", "\"TBL_RLOCALIDAD\"", column: "LOC_NID", primary_key: "LOC_NID", name: "TBL_RBARRIO_LOC_NID_fkey"
  add_foreign_key "TBL_RUSUARIOS", "\"TBL_RPERFIL\"", column: "PER_NID", primary_key: "PER_NID", name: "TBL_RUSUARIO_PER_NID_fkey"
  add_foreign_key "TBL_TCAPACITACION", "\"TBL_RCENTRO_TECNICO\"", column: "CTEC_NID", primary_key: "CTEC_NID", name: "TBL_TCAPACITACION_CTEC_NID_fkey"
  add_foreign_key "TBL_TINFRACION", "\"TBL_RBARRIO\"", column: "BAR_NID", primary_key: "BAR_NID", name: "TBL_TINFRACION_BAR_NID_fkey"
  add_foreign_key "TBL_TINFRACION", "\"TBL_RTIPO_VEHICULO\"", column: "TIPV_NID", primary_key: "TIPV_NID", name: "TBL_TINFRACION_TIPV_NID_fkey"
  add_foreign_key "TBL_TINFRACION", "\"TBL_RUSUARIOS\"", column: "USU_NID", primary_key: "USU_NID", name: "TBL_TINFRACION_USU_NID_fkey"
  add_foreign_key "TBL_TINFRACION_DET", "\"TBL_RNORMA\"", column: "NORM_NID", primary_key: "NORM_NID", name: "TBL_TINFRACION_DET_NORM_NID_fkey"
  add_foreign_key "TBL_TINFRACION_DET", "\"TBL_TINFRACION\"", column: "INF_NID", primary_key: "INF_NID", name: "TBL_TINFRACION_DET_INF_NID_fkey"
  add_foreign_key "TBL_UCAPACITACION_INFRACCION", "\"TBL_TCAPACITACION\"", column: "CAP_NID", primary_key: "CAP_NID", name: "TBL_UCAPACITACION_INFRACCION_CAP_NID_fkey"
  add_foreign_key "TBL_UCAPACITACION_INFRACCION", "\"TBL_TINFRACION\"", column: "INF_NID", primary_key: "INF_NID", name: "TBL_UCAPACITACION_INFRACCION_INF_NID_fkey"
  add_foreign_key "TBL_UINFRACION_EVIDENCIA", "\"TBL_TEVIDENCIA\"", column: "EVID_NID", primary_key: "EVID_NID", name: "TBL_UINFRACION_EVIDENCIA_EVID_NID_fkey"
  add_foreign_key "TBL_UINFRACION_EVIDENCIA", "\"TBL_TINFRACION\"", column: "INF_NID", primary_key: "INF_NID", name: "TBL_UINFRACION_EVIDENCIA_INF_NID_fkey"
end
