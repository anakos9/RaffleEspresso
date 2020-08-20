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

  def self.format_mail_hash_from_csv_row(line)
    if line
      email_domain = line.compact[0].gsub(/.+@([^.]+).+/, '\1')
      mail_details = {
        first_name:   line.compact[3],
        last_name:    line.compact[4],
        street_and_number: line.compact[5],
        zip_code:     line.compact[6],
        city:         line.compact[7],
        size:         line.compact[8],
        phone_number: line.compact[9],
        item_name:    line.compact[10],
        from_domain:  email_domain
      }
      mail_details
    end
  end
end