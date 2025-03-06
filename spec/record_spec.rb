RSpec.describe JsonSearch::Record do
  let(:attributes) { { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com', 'age' => 30 } }
  subject(:record) { described_class.new(attributes) }

  describe '#to_h' do
    it 'returns all attributes as a hash' do
      expect(record.to_h).to eq(attributes)
    end
  end

  describe '#[]' do
    it 'accesses attributes with string keys' do
      expect(record['full_name']).to eq('John Doe')
    end

    it 'accesses attributes with symbol keys' do
      expect(record[:email]).to eq('john@example.com')
    end

    it 'returns nil for keys that do not exist' do
      expect(record['nonexistent']).to be_nil
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the attributes' do
      expect(record.to_s).to eq(attributes.to_s)
    end
  end
end
