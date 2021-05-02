class Beneficio < BaseModel
  belongs_to :beneficiario
  belongs_to :organizacao_plano
  has_one :beneficio_condicao, dependent: :destroy
  has_one :condicao, through: :beneficio_condicao
  delegate :plano, to: :organizacao_plano, allow_nil: true
  delegate :organizacao, to: :organizacao_plano, allow_nil: true
  accepts_nested_attributes_for :beneficio_condicao,reject_if: :all_blank,  allow_destroy: true
  validates_associated :beneficio_condicao
  validates_presence_of :beneficio_condicao

  def valor_fatura_corte_atual
    return premio * 0 if not calculavel?
    return premio if corte_standard?
    return valor_primeiro_corte if primeiro_corte?
    return valor_ultimo_corte if ultimo_corte?
  end

  def premio
    organizacao_plano.premio_efetivo
  end

  def prorata?
    organizacao.prorata
  end

  def dia_corte
    organizacao_plano.dia_corte
  end

  def valor_primeiro_corte
    if prorata?
      valor_proporcional =  ((30.to_f - data_inclusao.day).to_f / 30) * premio
      incluso_antes_do_dia_corte? ? valor_proporcional : premio + valor_proporcional
    else
      incluso_antes_do_dia_corte? ? premio : premio * 2
    end
  end

  def valor_ultimo_corte
    if prorata?
      ((30.to_f - data_exclusao.day) / 30) * premio
    else
      premio * 0
    end
  end

  private

  def vigente?
    (data_inclusao + vigencia.months) >= data_corte_mes_atual && data_exclusao.nil?
  end

  def incluso_antes_do_dia_corte?
    data_inclusao.day <= dia_corte
  end

  def excluido_antes_do_dia_corte?
    data_exclusao.day <= dia_corte
  end

  def data_primeiro_corte
    if incluso_antes_do_dia_corte?
      Date.new(data_inclusao.year,data_inclusao.month,dia_corte)
    else
      Date.new(data_inclusao.year,data_inclusao.month,dia_corte) + 1.month
    end
  end

  def data_ultimo_corte
    return nil if data_exclusao.nil?
    if excluido_antes_do_dia_corte?
      Date.new(data_exclusao.year,data_exclusao.month,dia_corte)
    else
      Date.new(data_exclusao.year,data_exclusao.month,dia_corte) + 1.month
    end
  end

  def data_corte_mes_atual
    today = Date.today
    Date.new(today.year, today.month, dia_corte)
  end

  def primeiro_corte?
    data_primeiro_corte == data_corte_mes_atual
  end

  def ultimo_corte?
    return false if data_ultimo_corte.nil?
    data_ultimo_corte  == data_corte_mes_atual
  end

  def corte_standard?
    !primeiro_corte? && !ultimo_corte?
  end


  def calculavel?
    if vigente?
      data_corte_mes_atual >= data_primeiro_corte
    else
      data_corte_mes_atual <= data_ultimo_corte
    end
  end

end
