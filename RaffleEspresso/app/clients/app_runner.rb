require_relative 'input_service.rb'
require_relative 'email_client.rb'
require 'csv'
require 'net/smtp'
require 'simple_mail_builder'
require 'mail'
require 'openssl'

# FOR THIS TO WORK THE USER MUST TURN ON 'ALLOW LESS SECURE APPS IN GMAIL SETTINGS

file_name = InputService.get_file_name_input

puts "\n"

csv_lines = []
CSV.foreach(file_name) do |row|
  csv_lines << row
end

success_count = 0
failure_count = 0
total_entry_count = 0
csv_lines.each do |line|
  email_from = line.compact[0]
  email_domain = email_from.gsub(/.+@([^.]+).+/, '\1')
  email_pass = line.compact[1]
  recipient_email = line.compact[2]
  mail_content = InputService.format_mail_hash_from_csv_row(line)
  puts "Entry #1" if total_entry_count == 0
  puts "Entry ##{total_entry_count}" if total_entry_count > 0
  puts "Preparing entry for #{email_from}..."
  puts "Waiting to send..."
  sleep 20
  puts "Processing email from #{email_from} to #{recipient_email}..."
  if EmailClient.new(recipient_email, email_from, email_pass, mail_content).result == "success"
    success_count = success_count + 1
    puts "\nEntry successful!\n"
  else
    failure_count = failure_count + 1
    puts "\nEntry failed.\n"
  end
  total_entry_count = total_entry_count + 1
end

puts "-------------------------------------------\n"
puts "\nEntries for #{file_name} completed!\n"
puts "-------------------------------------------\n"
puts "Successful entries exported to successful_entries.txt!\n" if success_count > 0
puts "-------------------------------------------\n"
puts "Total failed entries: #{failure_count}"
puts "-------------------------------------------\n"
puts "Total successful entries: #{success_count}"
puts "-------------------------------------------\n"
puts "Total entries: #{total_entry_count}\n"
puts "-------------------------------------------\n"
puts "Success rate for this email batch: %#{((success_count/total_entry_count.to_f) * (100.to_f)).round}\n"
puts "-------------------------------------------\n"
