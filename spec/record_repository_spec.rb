require 'tempfile'
require 'json'

RSpec.describe JsonSearch::RecordRepository do
  context 'with a valid JSON file' do
    let(:json_data) do
      <<-JSON
      [
        {"id": 1, "full_name": "Alice", "email": "alice@example.com"},
        {"id": 2, "full_name": "Bob", "email": "bob@example.com"}
      ]
      JSON
    end

    it 'loads records correctly' do
      Tempfile.create('data.json') do |f|
        f.write(json_data)
        f.rewind
        repo = described_class.new(f.path)
        expect(repo.records.size).to eq(2)
        expect(repo.records.first['full_name']).to eq('Alice')
      end
    end
  end

  context 'when file is not found' do
    it 'prints an error and returns an empty array' do
      expect {
        repo = described_class.new('non_existent_file.json')
        expect(repo.records).to eq([])
      }.to output(/File not found/).to_stdout
    end
  end

  context 'with an invalid JSON file' do
    it 'prints an error and returns an empty array' do
      Tempfile.create('invalid.json') do |f|
        f.write('invalid json')
        f.rewind
        expect {
          repo = described_class.new(f.path)
          expect(repo.records).to eq([])
        }.to output(/Invalid JSON format/).to_stdout
      end
    end
  end
end
