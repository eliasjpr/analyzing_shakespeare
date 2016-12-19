require 'nokogiri'
require './lib/speech'

RSpec.describe Speech do
  let!(:xml_node) do
    Nokogiri::XML.parse <<-XML
    <SPEECH><SPEAKER>Maximus Decimus Meridius</SPEAKER>
    <LINE>What We Do In Life, Echos In Eternity</LINE>
    <LINE>Are you not entertained?</LINE></SPEECH>
    XML
  end

  let(:speech) { Speech.new xml_node.xpath('//SPEECH') }

  let(:lines) {
    ['What We Do In Life, Echos In Eternity', 'Are you not entertained?']
  }

  describe '#name' do
    it 'returns the speaker from xml document' do
      expect(speech.name).to eq 'Maximus Decimus Meridius'
      expect(speech.name).to be_a String
    end
  end

  describe '#lines' do
    it 'returns the speaker from xml document' do
      expect(speech.lines).to eq lines
      expect(speech.lines).to be_an Array
    end
  end

  describe '#to_s' do
    it 'outputs the number of lines and speaker' do
      expect(speech.to_s).to eq "2\tMaximus Decimus Meridius"
    end
  end

  describe '#total_lines' do
    it 'returns the size of lines' do
      expect(speech.lines.size).to eq xml_node.children.search('LINE').size
      expect(speech.lines.size).to be_an Integer
    end
  end
end
