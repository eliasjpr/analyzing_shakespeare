require 'nokogiri'
require 'play_downloader'
# Parses xml play object to be analyze
class Play
  attr_reader :root, :name_path, :lines_path

  def self.xml_doc(url)
    new(url).xml_doc
  end

  def initialize(url)
    @url = url
  end

  def xml_doc
    Nokogiri::XML.parse download
  end

  private

  def download
    PlayDownloader.fetch(@url)
  end
end
