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

FileService.reset_previous_success

success_count = 0
failure_count = 0
total_entry_count = -1
csv_lines.each do |line|
  email_from = line.compact[0]
  email_domain = email_from.gsub(/.+@([^.]+).+/, '\1')
  email_pass = line.compact[1]
  recipient_email = line.compact[2]
  mail_content = InputService.format_mail_hash_from_csv_row(line)
  dummy_line = total_entry_count == -1 ? true : false
  total_entry_count = total_entry_count + 1 if dummy_line == false

  if dummy_line
    puts "Burning dummy entry email please wait....\n"
  else
    puts "\nEntry ##{total_entry_count}"
    puts "Preparing entry for #{email_from}..."
    puts "Waiting to send..."
  end
  sleep 20
  puts "Processing email from #{email_from} to #{recipient_email}..." unless dummy_line
  if EmailClient.new(recipient_email, email_from, email_pass, mail_content).result == "success"
    success_count = success_count + 1
    puts "Entry successful!\n"
  else
    if dummy_line
      puts "Dummy email burned begininning entries...\n"
    else
      failure_count = failure_count + 1
      puts "Entry failed. Unable to login to email.\n"
    end
  end
  total_entry_count = total_entry_count + 1 if dummy_line == true
  puts "\n--------------------------------------------------------------------------------------\n"
end

InputService.format_and_print_results(file_name, success_count, failure_count, total_entry_count)
