require './lib/play_analyzer'
require 'net/http'
require 'webmock/rspec'

RSpec.describe PlayAnalyzer do
  let(:xml_data) { File.read('./spec/xml_files/play_example.xml') }
  subject { PlayAnalyzer.new('http://www.example.com') }

  before do
    stub_request(:get, 'http://www.example.com/').with(headers: {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent' => 'Ruby'}).to_return(status: 200, body: xml_data, headers: {})
    subject.analyze
  end

  describe '#analyze' do
    it 'returns a list of lines spoken by characters' do
      expect(subject.analysis).not_to be_empty
      expect(subject.analysis).to be_a Hash
    end

    it 'does not return All speaker' do
      expect(subject.analysis).not_to have_key 'ALL'
    end
  end

  describe '#to_s' do
    let(:line) { subject.analysis.first }

    it 'returns a line spoken by characters' do
      expect{ subject.print_all }.to output("2\tFirst Witch\n2\tSecond Witch\n").to_stdout
    end
  end
end
