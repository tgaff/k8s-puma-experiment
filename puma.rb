require 'rack'
# might only work with rack 2?

# threads 6,24
# workers 2

workers Integer(ENV['WEB_CONCURRENCY'] || 1)
max_threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 1)
min_threads_count = max_threads_count
threads min_threads_count, max_threads_count
activate_control_app 'tcp://0.0.0.0:9293', { auth_token: '12345' }

rackup 'app.ru'

puts 'rack\'dup with puma.rb'

bind 'tcp://0.0.0.0:9292'
