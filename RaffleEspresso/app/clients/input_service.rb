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

end