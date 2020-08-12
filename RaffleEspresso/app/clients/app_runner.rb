require_relative 'file_service.rb'
require_relative 'input_service.rb'
require 'csv'
require 'net/smtp'
require 'simple_mail_builder'
require 'mail'

# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS

file_name = InputService.get_file_name_input

recipient_email = InputService.get_recipient_name

p "File_name to s", file_name.to_s

p "Recipient email name", recipient_email

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

p "Line - count", csv_lines.count
p "Table readout from #{file_name}:"

# count = 0

csv_lines.each do |line|
  p "line", line
  email = line.compact[0]
  pass = line.compact[1]
  p "Email ->", email
  p "Pass ->", pass
end

email_2 = "tontrongdung50176@gmail.com"
pass_2 = "MANUtd7910!$@"

p "Beginning Mail Send Attempt from #{email_2}"


Mail.defaults do
  delivery_method :smtp, { :address    => "smtp.gmail.com",
                          :port       => 587,
                          :user_name  => email_2,
                          :password   => pass_2,
                          :authentication => :plain,
                          :enable_starttls_auto => true
                        }
end

# count = count + 1

p "Sending mail now..."

mail = Mail.new do
  from     "#{email_2}"
  to       "#{recipient_email}"
  subject  "Raffle Email Test"
  body     "Test content"
  #add_file :filename => 'somefile.png', :content => File.read('/somefile.png')
end

p "Mail successfully sent to #{email_2}!"
p "Mail receipt:", mail

mail.deliver!
