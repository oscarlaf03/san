Organizacao.all.each do |org|
  if org.users.blank?
    2.times do
      FactoryBot.create(:user, organizacao: org)
    end
  end
end
