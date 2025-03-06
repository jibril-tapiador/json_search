require 'json'

module JsonSearch
  class RecordRepository
    attr_reader :records

    def initialize(file_path)
      @records = load_records(file_path)
    end

    private

    def load_records(file_path)
      file = File.read(file_path)
      data = JSON.parse(file)
      data.map { |record_attrs| Record.new(record_attrs) }
    rescue Errno::ENOENT
      puts "File not found: #{file_path}"
      []
    rescue JSON::ParserError
      puts "Invalid JSON format in file: #{file_path}"
      []
    end
  end
end
