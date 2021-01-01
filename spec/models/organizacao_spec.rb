require 'rails_helper'

RSpec.describe Organizacao, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context " Organizacao Relationships" do
    it "Tiene muchos planos por OrganizacaoPlano" do
      org = create(:organizacao)
      plano = create(:plano)
      expect org.planos.first == plano
    end

    
  end
end
