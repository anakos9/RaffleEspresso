require_relative 'file_service.rb'
require_relative 'input_service.rb'
require 'csv'
require 'net/smtp'
require 'simple_mail_builder'
require 'mail'
# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS'

file_name = InputService.get_file_name_input
p "File_name to s", file_name.to_s

csv_lines = []
CSV.foreach(file_name) do |row|
  p row
  csv_lines << row
end

p "Line - count", csv_lines.count
p "Table readout from #{file_name}:"
csv_lines.each do |line|
  p line.compact
end

# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS'
# p "Beginning Mail Send Attempt from Alex.nakos9@gmail.com"

# Mail.defaults do
#   delivery_method :smtp, { :address    => "smtp.gmail.com",
#                           :port       => 587,
#                           :user_name  => 'toesrpurple@gmail.com',
#                           :password   => "1234@1234aA",
#                           :authentication => :plain,
#                           :enable_starttls_auto => true
#                         }
# end
# p "Sending mail now..."
# mail = Mail.new do
#   from     'toesrpurple@gmail.com'
#   to       'alex@rentgrata.com'
#   subject  'TEST MAIL FROM RAILS APP'
#   body     'Hey there!'
#   #add_file :filename => 'somefile.png', :content => File.read('/somefile.png')
# end

#p "Mail successfully sent!" if mail.present?
#p "Mail receipt:", mail

# mail.deliver!

# message = SimpleMailBuilder::Message.new(
#   to: {'Recipient' => 'Alex.nakos9@gmail.com'},
#   from: 'alex@rentgrata.com',
#   reply_to: 'reply-to@domain.com',
#   subject: 'Test Email',
#   text: "Header\n\nFirst line\nLast line",
#   html: '<h1>Header</h1><p>First line</p><p>Last line</p>'
# ).to_s
# Net::SMTP.start('localhost', 1025) do |smtp|
#   smtp.send_message message, 'alex@rentgrata.com', 'Alex.nakos9@gmail.com'
# end

# message = <<MESSAGE_END
# From: Private Person <alex@rentgrata.com>
# To: A Test User <Alex.nakos9@gmail.com>
# MIME-Version: 1.0
# Content-type: text/html
# Subject: SMTP e-mail test

# This is an e-mail message to be sent in HTML format

# <b>This is HTML message.</b>
# <h1>This is headline.</h1>
# MESSAGE_END

# Net::SMTP.start('localhost') do |smtp|
#   smtp.send_message message, 'alex@rentgrata.com', 
#                              'Alex.nakos9@gmail.com'
# end
