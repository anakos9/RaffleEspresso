class EmailClient
  require TestClient

  def initialize
    @client = client
  end

  # class << self

  # end

  puts "Please enter your name"
  name = gets.chomp
  @client = TestClient.new
  puts "Hello, #{name}! I'm Ruby!"
  p "CLient talk ->", @client.speak

end