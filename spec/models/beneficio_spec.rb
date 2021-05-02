require 'rails_helper'

RSpec.describe Beneficio, type: :model do

  context "#valor_fatura_corte_atual sem prorata" do

    it "fatura mes atual quando recem incluso dentro do corte" do
      beneficio =  beneficio_recem_incluido(dentro_do_corte: true, prorata:false)
      premio = beneficio.premio
      expect(premio  == beneficio.valor_fatura_corte_atual).to be true
    end

    it "fatura mes atual quando recem incluso fora do corte" do
      beneficio =  beneficio_recem_incluido(dentro_do_corte: false, prorata:false)
      premio = beneficio.premio
      expect(premio * 0  == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'fatura mes atual quando recem excluido dentro do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: true, prorata: false)
      expect(beneficio.premio * 0 == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'fatura mes atual quando recem excluido fora do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: false, prorata: false)
      expect(beneficio.premio == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'valor primeira fatura quando recem incluso dentro do corte' do
      beneficio = beneficio_recem_incluido(dentro_do_corte: true, prorata: false)
      expect(beneficio.valor_primeiro_corte == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'valor primeira fatura quando recem incluso fora do corte' do
      beneficio = beneficio_recem_incluido(dentro_do_corte: false, prorata: false)
      premio = beneficio.premio
      expect(beneficio.valor_primeiro_corte == premio * 2).to be true
    end

    it 'valor ultima fatura quando recem excluido dentro do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: true, prorata: false)
      premio = beneficio.premio
      expect(beneficio.valor_ultimo_corte == premio * 0).to be true
    end

    it 'valor ultima fatura quando recem excluido fora do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: false, prorata: false)
      premio = beneficio.premio
      expect(beneficio.valor_ultimo_corte == premio * 0).to be true
    end


  end

  context "#valor_fatura_corte_atual com prorata" do


    it "fatura mes atual quando recem incluso dentro do corte" do
      beneficio =  beneficio_recem_incluido(dentro_do_corte: true, prorata: true)
      proporcional = (30.to_f - beneficio.data_inclusao.day) / 30
      premio = beneficio.premio
      expect(premio * proporcional  == beneficio.valor_fatura_corte_atual).to be true
    end

    it "fatura mes atual quando recem incluso fora do corte" do
      beneficio =  beneficio_recem_incluido(dentro_do_corte: false, prorata: true)
      premio = beneficio.premio
      expect(premio * 0  == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'fatura mes atual quando recem excluido dentro do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: true, prorata: true)
      proporcional = (30.to_f - beneficio.data_exclusao.day) / 30
      premio = beneficio.premio
      expect( premio * proporcional == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'fatura mes atual quando recem excluido fora do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: false, prorata: true)
      expect(beneficio.premio == beneficio.valor_fatura_corte_atual).to be true
    end

    it 'valor primeira fatura quando recem incluso dentro do corte' do
      beneficio = beneficio_recem_incluido(dentro_do_corte: true, prorata: true)
      proporcional = (30.to_f - beneficio.data_inclusao.day) / 30
      premio = beneficio.premio
      expect(beneficio.valor_primeiro_corte  == premio * proporcional).to be true
    end

    it 'valor primeira fatura quando recem incluso fora do corte' do
      beneficio = beneficio_recem_incluido(dentro_do_corte: false, prorata: true)
      proporcional = (30.to_f - beneficio.data_inclusao.day) / 30
      premio = beneficio.premio
      expect(beneficio.valor_primeiro_corte == premio + (premio * proporcional)).to be true
    end

    it 'valor ultima fatura quando recem excluido dentro do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: true, prorata: true)
      premio = beneficio.premio
      proporcional = (30.to_f - beneficio.data_exclusao.day) / 30
      premio = beneficio.premio
      expect(beneficio.valor_ultimo_corte == premio * proporcional).to be true
    end

    it 'valor ultima fatura quando recem excluido fora do corte' do
      beneficio = beneficio_recem_excluido(dentro_do_corte: false, prorata: true)
      premio = beneficio.premio
      proporcional = (30.to_f - beneficio.data_exclusao.day) / 30
      expect(beneficio.valor_ultimo_corte == premio * proporcional).to be true
    end

  end

  context "Relationships" do
    let(:beneficio) {create(:beneficio)}
    let(:condicao) {create(:condicao)}
    it "tem uma condicao through condicao" do
      expect(beneficio.condicao.kind_of?(Condicao)).to be true
    end

    it "Responde para plano retornando o Plano" do
      expect(beneficio.plano.kind_of?(Plano)).to be true
    end

    it "Responde para organizacao retornando uma Organizacao" do
      expect(beneficio.organizacao.kind_of?(Organizacao)).to be true
    end

  end
end
