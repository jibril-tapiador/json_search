require 'optparse'

module JsonSearch
  class CLI
    DEFAULT_FILE = File.join(Gem.loaded_specs["json_search"].full_gem_path, 'data', 'clients.json')

    def initialize(args = ARGV)
      @args = args
      @options = {}
      parse_options
    end

    def run
      file_path = @options[:file] || DEFAULT_FILE
      repository = RecordRepository.new(file_path)
      records = repository.records

      if @options[:search]
        handle_search(records)
      elsif @options[:duplicates]
        handle_duplicates(records)
      else
        puts 'Please specify an option: -s/--search QUERY or -d/--duplicates.'
      end
    end

    private

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: json_search [options]'
        opts.on('-f', '--file FILE', 'Path to the JSON file (default: data/clients.json)') do |file|
          @options[:file] = file
        end
        opts.on('-s', '--search QUERY', 'Search records by full_name') do |query|
          @options[:search] = query
        end
        opts.on('-d', '--duplicates', 'Find records with duplicate emails') do
          @options[:duplicates] = true
        end
        opts.on('-h', '--help', 'Show help message') do
          puts opts
          exit
        end
      end.parse!(@args)
    end

    def handle_search(records)
      service = SearchService.new(records)
      results = service.search(@options[:search])
      if results.empty?
        puts "No records found matching '#{@options[:search]}' in 'full_name'."
      else
        puts 'Search results:'
        results.each { |record| puts record.to_h }
      end
    end

    def handle_duplicates(records)
      checker = DuplicateChecker.new(records)
      duplicates = checker.find_duplicates
      if duplicates.empty?
        puts 'No duplicate emails found.'
      else
        puts 'Duplicate emails found:'
        duplicates.each do |group|
          group.each { |record| puts record.to_h }
        end
      end
    end
  end
end
