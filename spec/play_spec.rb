require './lib/play'
require 'nokogiri'

RSpec.describe Play do
  let(:url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }
  let(:content) { File.read('./spec/xml_files/play_example.xml') }
  describe '.xml_doc' do
    before do
      downloader = instance_double('PlayDownloader')
      allow(downloader).to receive(:fetch).and_return(content)
    end

    it 'parses a XML string and returns an Nokogiri::XML::Document' do
      response = Play.xml_doc(url)
      expect(response).to be_an_instance_of(Nokogiri::XML::Document)
    end
  end
end
