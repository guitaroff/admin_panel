admin = Administrator.last
if admin
  puts 'Админ уже существует.'
else
  Administrator.create(
    email:      Rails.application.credentials.admin[:email],
    password:   Rails.application.credentials.admin[:password],
    first_name: 'Admin',
    last_name:  'User'
  )
  puts 'Админ успешно создан.'
end
