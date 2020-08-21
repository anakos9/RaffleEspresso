class FileService
#   require 'csv'

  def successful_entries(s_array)
    p "Test line 5 FileService"
    File.write("log.txt", s_array.join("\n"), mode: "a")
  end

end