class EmailClient
  require 'mail'
  require 'redis'
  # include TestClient

  # def initialize
  #   @client = client
  # end

  # class << self

  # end

  # p "CLient talk ->", @client.speak
  # p "Writting to a new file"
  # File.write("new---log.txt", "Name from input: #{name}")
  c = Redis.new
  c.set("email_a", "alex@gmail.com")
  c.set("pass", "123123")
  p "Testing email send locally"
  p "Email retrieval", c.get("email_a")
  p "Password retrieval", c.get("pass")
  # Mail.deliver do
  #     to 'alex@rentgrata.com'
  #   from 'alex.nakos9@gmail.com'
  #   subject 'SENDING FROM RAILS APP TEST TEST TEST'
  #   body 'TEST EMAIL'
  # end

end