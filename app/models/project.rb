class Project < ActiveRecord::Base

	def self.import(file)
     spreadsheet = open_spreadsheet(file)
     header = spreadsheet.row(1)
  (1..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    puts "lllllllllllssssssssssssssrowwwwwwww",row.to_hash
    project = find_by_id(row["id"]) || new
    puts "lllllllllllssssssssssssss",row.to_hash
    puts "ssssssssssssssssss",project.attributes = row.to_hash
    project.save!
  end
end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Csv.new(file.path, nil, :ignore)
		when ".xls" then Excel.new(file.path, nil, :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end
end
