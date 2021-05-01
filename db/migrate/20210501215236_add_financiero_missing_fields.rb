class AddFinancieroMissingFields < ActiveRecord::Migration[6.0]
  def change
    add_monetize  :organizacao_planos, :premio_efetivo, currency: { present: false }
    add_column  :organizacao_planos, :dia_corte, :integer
    add_column  :beneficios, :data_inclusao, :date
    add_column  :beneficios, :data_exclusao, :date
    add_column  :beneficios, :vigencia, :integer
    add_column  :organizacoes, :prorata, :boolean, default: :false

  end
end
