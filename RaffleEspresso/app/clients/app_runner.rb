require_relative 'file_service.rb'
require_relative 'input_service.rb'
require_relative 'email_client.rb'
require 'csv'
require 'net/smtp'
require 'simple_mail_builder'
require 'mail'
require 'openssl'
# require 'net/smtp/proxy'

# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS

file_name = InputService.get_file_name_input

recipient_email = InputService.get_recipient_name

p "File_name to s", file_name.to_s

p "Recipient email name", recipient_email

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

# TODO
# Section for:
# proxy_port
# proxy_address

count = 1
csv_lines.each do |line|
  p "line", line
  email_from = line.compact[0]
  email_domain = email_from.gsub(/.+@([^.]+).+/, '\1')
  email_pass = line.compact[1]
  p "Domain is gmail" if email_domain == "gmail"
  p "Domain is outlook" if email_domain == "outlook"

  p "Entry ##{count} ->"
  p "Sending to #{recipient_email} from #{email_from}...\n"
  p "Waiting to send..." if count > 1

  sleep 25

  count = count + 1 if EmailClient.new(recipient_email, email_from, email_pass, "Test email", "Testing email send from app", email_domain)
end

p "\nEmail batch completed!"
p "Total successful entries: #{count}"
