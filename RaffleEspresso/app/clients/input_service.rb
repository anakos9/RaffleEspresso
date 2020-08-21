class InputService

  def self.get_file_name_input
    puts "Please enter the name of the CSV file you would like to use:"
    name = gets.chomp
    return name
  end

  def self.get_recipient_name
    puts "Please enter the email of where you would like to submit your entries to:"
    email = gets.chomp
    return email
  end

  def self.format_and_print_results(file_name, success_count, failure_count, total_entry_count)
    puts "\n\n"
    puts "\n--------------------------------------------------------------------------------------\n"
    puts "Entries for #{file_name} completed!\n"
    puts "--------------------------------------------------------------------------------------\n"
    puts "Successful entries exported to successful_entries.txt!\n" if success_count > 0
    puts "--------------------------------------------------------------------------------------\n"
    puts "Total failed entries: #{failure_count}"
    puts "--------------------------------------------------------------------------------------\n"
    puts "Total successful entries: #{success_count}"
    puts "--------------------------------------------------------------------------------------\n"
    puts "Total entries: #{total_entry_count}\n"
    puts "--------------------------------------------------------------------------------------\n"
    puts "Success rate for this batch of entries: #{((success_count/total_entry_count.to_f) * (100.to_f)).round}%\n"
    puts "--------------------------------------------------------------------------------------\n"
  end

  def self.format_mail_hash_from_csv_row(line)
    if line
      email_domain = line.compact[0].gsub(/.+@([^.]+).+/, '\1')
      mail_details = {
        subject:      line.compact[3],
        first_name:   line.compact[4],
        last_name:    line.compact[5],
        street_and_number: line.compact[6],
        zip_code:     line.compact[7],
        city:         line.compact[8],
        size:         line.compact[9],
        phone_number: line.compact[10],
        item_name:    line.compact[11],
        from_domain:  email_domain
      }
      mail_details
    end
  end
  
end