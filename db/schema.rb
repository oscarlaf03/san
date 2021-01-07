# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_07_010958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beneficiarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "nome"
    t.string "nacionalidade"
    t.string "cpf"
    t.string "sexo"
    t.date "data_nascimento"
    t.string "estado_civil"
    t.string "nome_da_mae"
    t.string "telefone"
    t.string "cargo"
    t.date "admissao"
    t.integer "salario"
    t.string "papel"
    t.bigint "organizacao_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "titular_id"
    t.index ["email"], name: "index_beneficiarios_on_email", unique: true
    t.index ["organizacao_id"], name: "index_beneficiarios_on_organizacao_id"
    t.index ["reset_password_token"], name: "index_beneficiarios_on_reset_password_token", unique: true
  end

  create_table "beneficiarios_roles", force: :cascade do |t|
    t.bigint "beneficiario_id"
    t.bigint "role_id"
    t.index ["beneficiario_id", "role_id"], name: "index_beneficiarios_roles_on_beneficiario_id_and_role_id"
    t.index ["beneficiario_id"], name: "index_beneficiarios_roles_on_beneficiario_id"
    t.index ["role_id"], name: "index_beneficiarios_roles_on_role_id"
  end

  create_table "organizacao_planos", force: :cascade do |t|
    t.bigint "plano_id", null: false
    t.bigint "organizacao_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organizacao_id"], name: "index_organizacao_planos_on_organizacao_id"
    t.index ["plano_id"], name: "index_organizacao_planos_on_plano_id"
  end

  create_table "organizacoes", force: :cascade do |t|
    t.string "slug"
    t.string "razao_social"
    t.string "cnpj"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planos", force: :cascade do |t|
    t.string "nome"
    t.integer "premio_mensal"
    t.string "papel"
    t.string "acomodacao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seguradora_id"
    t.index ["seguradora_id"], name: "index_planos_on_seguradora_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "seguradoras", force: :cascade do |t|
    t.string "cnpj"
    t.string "razao_social"
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organizacao_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organizacao_id"], name: "index_users_on_organizacao_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "beneficiarios", "beneficiarios", column: "titular_id"
  add_foreign_key "organizacao_planos", "organizacoes"
  add_foreign_key "organizacao_planos", "planos"
end
