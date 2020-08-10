class EmailClient
  # include TestClient

  # def initialize
  #   @client = client
  # end

  # class << self

  # end

  puts "Please enter your name"
  name = gets.chomp
  # @client = TestClient.new
  puts "Hello, #{name}! I'm Ruby!"
  # p "CLient talk ->", @client.speak
  p "Writting to a new file"
  File.write("new--log.txt", "Name from input: #{name}")
end