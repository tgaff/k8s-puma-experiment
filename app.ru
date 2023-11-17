require_relative './junk'
class ExpApp
  FIRST_NAMES = %w(aaron abas abby abdul abel abraham avogadro austin arnold agatha).map {|s| s.capitalize }

  def initialize
    @glump = []
  end

  def call(env)
    body = 'Hello, World!' + " ----- I'm #{my_name} ----- ".ljust(30) + "glump length = #{@glump.length}\n"
    @glump.push JUNK+"alsdkfjasf"

    wait_as_needed

    [200, { 'content-type' => 'text/plain', 'content-length' => body.length.to_s }, [body]]
  end

  def my_name
    return @my_name if @my_name

    @my_name = "#{FIRST_NAMES.sample} #{rand(9999).to_s.ljust(4)}".freeze
    puts "Set my name: #{@my_name}"
    @my_name
  end

  def wait_as_needed
    @wait_factor ||= Integer(ENV['WAIT_FACTOR'] || 0)

    wait_time = @wait_factor * 0.001
    sleep wait_time
  end

end


puts "starting test app #{srand} ................................"
run ExpApp.new
