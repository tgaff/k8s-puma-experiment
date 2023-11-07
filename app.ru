class ExpApp
  def call(env)
    body = 'Hello, World!'
    # sleep 3
    [200, { 'content-type' => 'text/plain', 'content-length' => body.length.to_s }, [body]]
  end
end

run ExpApp.new
