class FileService

  def self.write_successful_entries(from_address)
    File.write("successful_entries.txt", "#{from_address}\n", mode: "a") if from_address.present?
  end

  def self.reset_previous_success
    begin
      f = File.open("successful_entries.txt", "w")
    ensure
      f.close unless f.nil? or f.closed?
      File.delete("successful_entries.txt") if File.exists? "successful_entries.txt"
    end
  end

end