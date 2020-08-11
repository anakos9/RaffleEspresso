class InputService

  def self.get_file_name_input
    puts "Please enter your CSV file name:"
    name = gets.chomp
    p "Name->", name
    return name
  end

end