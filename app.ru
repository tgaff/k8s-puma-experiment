class ExpApp
  def call(env)
   body = 'Hello, World!'
   sleep 3
   [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body]]
  end
end

run ExpApp.new
