class EmailClient
  require 'mail'
  require 'redis'
  require 'net/smtp'
  require 'simple_mail_builder'
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
  message = SimpleMailBuilder::Message.new(
    to: {'Recipient' => 'Alex.nakos9@gmail.com'},
    from: 'alex@rentgrata.com',
    reply_to: 'reply-to@domain.com',
    subject: 'Test Email',
    text: "Header\n\nFirst line\nLast line",
    html: '<h1>Header</h1><p>First line</p><p>Last line</p>'
  ).to_s
  Net::SMTP.start('localhost', 1025) do |smtp|
    smtp.send_message message, 'alex@rentgrata.com', 'Alex.nakos9@gmail.com'
  end
  # Mail.deliver do
  #     to 'alex@rentgrata.com'
  #   from 'alex.nakos9@gmail.com'
  #   subject 'SENDING FROM RAILS APP TEST TEST TEST'
  #   body 'TEST EMAIL'
  # end

end