require_relative 'file_service.rb'
require_relative 'input_service.rb'
require_relative 'email_client.rb'
require 'csv'
require 'net/smtp'
require 'simple_mail_builder'
require 'mail'
require 'openssl'

# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS

file_name = InputService.get_file_name_input

recipient_email = InputService.get_recipient_name

p "File_name to s", file_name.to_s

p "Recipient email name", recipient_email

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

count = 1
csv_lines.each do |line|
  p "line", line
  email_2 = line.compact[0]
  pass_2 = line.compact[1]
  p "Entry #{count}:"
  p "Sending to #{} from #{email_2}..."

  p "Waiting to send..." if count > 1
  sleep 25
  EmailClient.new("alex@rentgrata.com", email_2, pass_2, "Test email", "Testing email send from app")
end

p "Email batch completed!"
p "Total successful entries: #{}"
