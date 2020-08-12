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

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

p "Line - count", csv_lines.count
p "Table readout from #{file_name}:"

count = 0

csv_lines.each do |line|

  email = line.compact[0]
  pass = line.compact[1]

  p "Beginning Mail Send Attempt from #{email}"

  Mail.defaults do
    delivery_method :smtp, { :address    => "smtp.gmail.com",
                            :port       => 587,
                            :user_name  => "#{email}",
                            :password   => "#{pass}",
                            :authentication => :plain,
                            :enable_starttls_auto => true
                          }
  end

  count = count + 1
  
  p "Sending mail now..."

  mail = Mail.new do
    from     "#{email}"
    to       "#{recipient_email}"
    subject  "Raffle Email Test #{count}"
    body     "Test content ##{count}"
    #add_file :filename => 'somefile.png', :content => File.read('/somefile.png')
  end

  p "Mail successfully sent to #{email}!"
  p "Mail receipt:", mail

  mail.deliver!

end
