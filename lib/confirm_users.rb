User.where(confirmed_at: nil).update_all(confirmed_at: DateTime.now)
Beneficiario.where(confirmed_at: nil).update_all(confirmed_at: DateTime.now)
