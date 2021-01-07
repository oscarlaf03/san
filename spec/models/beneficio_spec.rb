require 'rails_helper'

RSpec.describe Beneficio, type: :model do
  context "Relationships" do
    it "tem uma condicao through beneficio_condicao" do
      beneficio = create(:beneficio)
      condicao = create(:condicao)
      create(:beneficio_condicao, beneficio: beneficio, condicao: condicao)
      expect(beneficio.condicao == condicao).to be true
    end

  end
end
