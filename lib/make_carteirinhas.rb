Beneficiario.all.each do |ben|
  if  ben.beneficio
    ben.beneficio.carteirinha  = Faker::Number.number(digits: 14).to_s
    ben.beneficio.save
  end
end
