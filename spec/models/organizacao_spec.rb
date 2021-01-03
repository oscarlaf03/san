require 'rails_helper'

RSpec.describe Organizacao, type: :model do
  context " Organizacao Relationships" do
    it "Tiene muchos planos por OrganizacaoPlano" do
      org = create(:organizacao)
      plano = create(:plano)
      expect org.planos.first == plano
    end

    
  end
end
