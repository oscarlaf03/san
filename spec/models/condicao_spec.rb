require 'rails_helper'

RSpec.describe Condicao, type: :model do
  context "Relationships" do

    it "Condicao tem muitos beneficios through beneficio_condicoes" do
      condicao = create(:condicao)
      5.times do
        create(:beneficio_condicao,condicao: condicao)
      end
      expect(condicao.beneficios.size).to eq(5)
    end

  end
end
