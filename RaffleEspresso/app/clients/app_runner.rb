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

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

count = 1
csv_lines.each do |line|
  email_from = line.compact[0]
  email_domain = email_from.gsub(/.+@([^.]+).+/, '\1')
  email_pass = line.compact[1]
  recipient_email = line.compact[2]
  mail_content = InputService.format_mail_hash_from_csv_row(line)
  p "Entry ##{count}"
  p "Preparing entry..."
  p "Waiting to send..."
  sleep 20
  p "Processing email from #{email_from} to #{recipient_email}..."
  if EmailClient.new(recipient_email, email_from, email_pass, mail_content) != false
    count = count + 1
    p "Email sent. Entry successful!"
  else
    p "Entry failed."
  end
end

p "Email batch completed!"
p "Total successful entries: #{count}"
