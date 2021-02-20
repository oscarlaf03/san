Seguradora.all.each do |seg|
  5.times do
    FactoryBot.create(:plano, seguradora: seg)
  end
end
