require_relative 'file_service.rb'
require_relative 'input_service.rb'
require_relative 'email_client.rb'
require 'csv'

file_name = InputService.get_file_name_input
p "File_name to s", file_name.to_s

csv_lines = []
CSV.foreach(file_name) do |row|
  p row
  csv_lines << row
end

p "Line - count", csv_lines.count
p "Table readout from #{file_name}:"
csv_lines.each do |line|
  p line.compact
end

