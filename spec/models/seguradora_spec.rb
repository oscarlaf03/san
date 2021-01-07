require 'rails_helper'

RSpec.describe Seguradora, type: :model do

  context "Testes relationships" do
    it "has_many planos" do
      seg = create(:seguradora)
      5.times do
        create(:plano, seguradora: seg)
      end
      expect(seg.planos.size).to eq(5)
    end

  end
end
