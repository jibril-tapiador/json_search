require 'tempfile'
require 'json'
require 'stringio'

RSpec.describe JsonSearch::CLI do
  def run_cli(args)
    original_stdout = $stdout
    $stdout = StringIO.new
    begin
      JsonSearch::CLI.new(args).run
      $stdout.string
    ensure
      $stdout = original_stdout
    end
  end

  context 'when no options are provided' do
    it 'shows an error message' do
      output = run_cli([])
      expect(output).to include('Please specify an option')
    end
  end

  context 'when search option is provided' do
    let(:data) do
      [
        { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
        { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' }
      ]
    end

    let(:json_file) do
      file = Tempfile.new('test_data.json')
      file.write(data.to_json)
      file.rewind
      file.path
    end

    after { File.delete(json_file) if File.exist?(json_file) }

    it 'returns matching records' do
      output = run_cli(['-f', json_file, '-s', 'John'])
      expect(output).to include('John Doe')
    end

    it 'returns a message if no records match' do
      output = run_cli(['-f', json_file, '-s', 'Nonexistent'])
      expect(output).to include('No records found')
    end
  end

  context 'when duplicate option is provided' do
    let(:data) do
      [
        { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'dup@example.com' },
        { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'unique@example.com' },
        { 'id' => 3, 'full_name' => 'Johnny', 'email' => 'dup@example.com' }
      ]
    end

    let(:json_file) do
      file = Tempfile.new('test_data.json')
      file.write(data.to_json)
      file.rewind
      file.path
    end

    after { File.delete(json_file) if File.exist?(json_file) }

    it 'returns duplicate records' do
      output = run_cli(['-f', json_file, '-d'])
      expect(output).to include('dup@example.com')
    end
  end
end
