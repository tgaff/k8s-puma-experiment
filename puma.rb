require 'rack'
# might only work with rack 2?
rackup 'app.ru'

puts 'custom'

bind 'tcp://127.0.0.1:3000'
