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