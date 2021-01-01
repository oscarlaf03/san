require 'rails_helper'

RSpec.describe Beneficiario, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Relationships" do 
    it "Pertence a uma organizacao" do
    org = create(:organizacao)
    b = create(:beneficiario, organizacao: org)

    expect b.organizacao  == org
    
    end
  end
end
