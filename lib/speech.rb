# Builds a speech object
class Speech
  SPEAKER = 'SPEAKER'.freeze
  LINE = 'LINE'.freeze

  attr_accessor :name, :lines

  def initialize(speech_xml_node)
    @xml_node = speech_xml_node
    @name = @xml_node.search(SPEAKER).text
    @lines = @xml_node.search(LINE).map do |e|
      e.children.text
    end
  end

  def total_lines
    lines.size
  end

  def to_s
    "#{total_lines}\t#{name}"
  end
end
