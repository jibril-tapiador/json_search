RSpec.describe JsonSearch::SearchService do
  let(:record1) { double('record', 'full_name' => 'Alice Wonderland') }
  let(:record2) { double('record', 'full_name' => 'Bob Builder') }
  let(:record3) { double('record', 'full_name' => 'Alicia Keys') }
  let(:record4) { double('record', 'full_name' => 12345) } # non-string value

  before do
    allow(record1).to receive(:[]).with('full_name').and_return('Alice Wonderland')
    allow(record2).to receive(:[]).with('full_name').and_return('Bob Builder')
    allow(record3).to receive(:[]).with('full_name').and_return('Alicia Keys')
    allow(record4).to receive(:[]).with('full_name').and_return(12345)
  end

  let(:records) { [record1, record2, record3, record4] }
  let(:service) { described_class.new(records) }

  it 'returns records matching the search query on full_name' do
    results = service.search('Ali')
    expect(results).to include(record1, record3)
    expect(results.size).to eq(2)
  end

  it 'is case insensitive' do
    results = service.search('bob')
    expect(results).to include(record2)
    expect(results.first['full_name']).to eq('Bob Builder')
  end

  it 'returns an empty array if no records match' do
    results = service.search('Nonexistent')
    expect(results).to be_empty
  end

  it 'ignores records where full_name is not a String' do
    results = service.search('123')
    expect(results).not_to include(record4)
  end
end
