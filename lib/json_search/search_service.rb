module JsonSearch
  class SearchService
    attr_accessor :records

    def initialize(records)
      @records = records
    end

    def search(query)
      records.select do |record|
        value = record['full_name']
        value.is_a?(String) && value.downcase.include?(query.downcase)
      end
    end
  end
end
