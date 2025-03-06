module JsonSearch
  class DuplicateChecker
    attr_accessor :records

    def initialize(records)
      @records = records
    end

    def find_duplicates
      # Use memoization to cache the duplicates result.
      @duplicates ||= compute_duplicates
    end

    private

    def compute_duplicates
      groups = records.group_by { |record| record['email'] }
      groups.select { |_, group| group.size > 1 }.values
    end
  end
end
