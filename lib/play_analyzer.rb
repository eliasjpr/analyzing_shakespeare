require './lib/speech'
require './lib/play'

# Analizes speeches
class PlayAnalyzer
  ROOT = '//SCENE//SPEECH'.freeze
  INGNORE_SPEAKERS = 'ALL'.freeze

  def self.analyze(url)
    new(url).analyze
  end

  def initialize(url)
    xml_doc = Play.xml_doc(url)
    @xml_doc = xml_doc
  end

  def analyze
    @speeches = Hash.new(0)
    @xml_doc.xpath(ROOT).each do |speech_node|
      speaker = Speech.new(speech_node)
      next if speaker.name == INGNORE_SPEAKERS
      @speeches[speaker.name] += speaker.total_lines
    end
    @speeches
  end

  def report
    @speeches.each do |speaker, lines|
      puts "#{lines}\t#{speaker}"
    end
  end

  private

  attr_reader :speeches
end
