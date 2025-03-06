RSpec.describe JsonSearch::DuplicateChecker do
  context 'when duplicates exist' do
    let(:record1) { double('record') }
    let(:record2) { double('record') }
    let(:record3) { double('record') }
    let(:record4) { double('record') }

    before do
      allow(record1).to receive(:[]).with('email').and_return('dup@example.com')
      allow(record2).to receive(:[]).with('email').and_return('unique@example.com')
      allow(record3).to receive(:[]).with('email').and_return('dup@example.com')
      allow(record4).to receive(:[]).with('email').and_return('dup@example.com')
    end

    let(:records_with_duplicates) { [record1, record2, record3, record4] }

    it 'finds duplicate records based on email' do
      checker = described_class.new(records_with_duplicates)
      duplicates = checker.find_duplicates
      expect(duplicates.size).to eq(1)
      expect(duplicates.first.size).to eq(3)
    end

    it 'handles multiple groups of duplicates' do
      record5 = double('record')
      record6 = double('record')
      allow(record5).to receive(:[]).with('email').and_return('group2@example.com')
      allow(record6).to receive(:[]).with('email').and_return('group2@example.com')

      records = records_with_duplicates + [record5, record6]
      checker = described_class.new(records)

      duplicates = checker.find_duplicates
      expect(duplicates.size).to eq(2)

      group_sizes = duplicates.map(&:size)
      expect(group_sizes).to include(3, 2)
    end
  end

  context 'when no duplicates exist' do
    let(:record1) { double('record') }
    let(:record2) { double('record') }
    let(:record3) { double('record') }

    before do
      allow(record1).to receive(:[]).with('email').and_return('alice@example.com')
      allow(record2).to receive(:[]).with('email').and_return('bob@example.com')
      allow(record3).to receive(:[]).with('email').and_return('charlie@example.com')
    end

    let(:records_without_duplicates) { [record1, record2, record3] }

    it 'returns an empty array if no duplicates are found' do
      checker = described_class.new(records_without_duplicates)
      duplicates = checker.find_duplicates
      expect(duplicates).to be_empty
    end
  end
end
