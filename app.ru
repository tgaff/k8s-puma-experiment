class ExpApp
  FIRST_NAMES = %w(aaron abas abby abdul abel abraham avogadro austin arnold agatha).map {|s| s.capitalize }

  def call(env)
    body = 'Hello, World!' + "\nI'm #{my_name}"
    # sleep 3
    [200, { 'content-type' => 'text/plain', 'content-length' => body.length.to_s }, [body]]
  end

  def my_name
    return @my_name if @my_name

    @my_name = "#{FIRST_NAMES.sample} #{rand(9999)}".freeze
    puts "Set my name: #{@my_name}"

  end
end

puts "starting test app................................#{srand}"
run ExpApp.new
