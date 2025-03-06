module JsonSearch
  class Record
    attr_accessor :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def [](key)
      attributes[key.to_s] || attributes[key.to_sym]
    end

    def to_h
      attributes
    end

    def to_s
      attributes.to_s
    end
  end
end
