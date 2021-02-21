if Doorkeeper::Application.find_by(name: "san_web")
  print "\n"
  puts "SAN_WEB_UID:  #{Doorkeeper::Application.find_by(name: 'san_web').uid}"
  puts "SAN_WEB_SECRET:  #{Doorkeeper::Application.find_by(name: 'san_web').secret}"
else
  puts "\nsan_web not present\n"
end


if Doorkeeper::Application.find_by(name: "san_app")
  puts "SAN_APP_UID:  #{Doorkeeper::Application.find_by(name: 'san_app').uid}"
  puts "SAN_APP_SECRET:  #{Doorkeeper::Application.find_by(name: 'san_app').secret}"
else
  puts "\nsan_app not present\n"
end
