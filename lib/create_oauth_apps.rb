if Doorkeeper::Application.find_by(name: "san_web").nil?
  Doorkeeper::Application.create(name: "san_web", redirect_uri: "", scopes: "")
end


if Doorkeeper::Application.find_by(name: "san_app").nil?
  Doorkeeper::Application.create(name: "san_app", redirect_uri: "", scopes: "")
end


puts "SAN_WEB_UID:  #{Doorkeeper::Application.find_by(name: 'san_web').uid}"
puts "SAN_WEB_SECRET:  #{Doorkeeper::Application.find_by(name: 'san_web').secret}"
print "\n\n"



puts "SAN_APP_UID:  #{Doorkeeper::Application.find_by(name: 'san_app').uid}"
puts "SAN_APP_SECRET:  #{Doorkeeper::Application.find_by(name: 'san_app').secret}"
print "\n\n"
