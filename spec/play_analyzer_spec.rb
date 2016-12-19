require './lib/play_analyzer'
require 'net/http'

RSpec.describe PlayAnalyzer do
  let!(:xml_data) { File.read('./spec/xml_files/play_example.xml') }
  let!(:parsed_xml) { Nokogiri::XML.parse xml_data }
  let!(:url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }
  let(:analysis) {  }

  before do
    play = instance_double('Play')
    allow(play).to receive(:xml_doc).and_return(parsed_xml)
    @analysis = PlayAnalyzer.analyze url
  end

  describe '#analyze' do
    it 'returns the number of lines spoken by characters' do
      expect(@analysis['MACBETH']).to eq(718)
      expect(@analysis['BANQUO']).to eq(113)
      expect(@analysis['DUNCAN']).to eq(70)
    end

    it 'does not return All speaker' do
      expect(@analysis).not_to have_key 'ALL'
    end
  end
end
