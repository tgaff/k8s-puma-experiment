require_relative './junk'
class ExpApp
  FIRST_NAMES = %w(aaron abas abby abdul abel abraham avogadro austin arnold agatha).map {|s| s.capitalize }

  def initialize
    @glump = []
  end

  def call(env)
    body = 'Hello, World!' + " ----- I'm #{my_name} ----- ".ljust(30) + "[#{short_puma_config}] glump length = #{@glump.length}\n"

    # glump is here to eat memory and help us achieve OOM.
    @glump.push JUNK + body

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
    sleep (wait_factor * 0.001)
  end

  def short_puma_config
    @short_puma_config ||= "P#{ENV.fetch('WEB_CONCURRENCY')}T#{ENV.fetch('RAILS_MAX_THREADS','x')}-W#{wait_factor}".freeze
  end

  def wait_factor
    @wait_factor ||= Integer(ENV['WAIT_FACTOR'] || 0)
  end
end


puts "starting test app #{srand} ................................"
run ExpApp.new
