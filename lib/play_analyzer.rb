require 'httparty'
require 'nokogiri'
# Analizes play
class PlayAnalyzer
  include HTTParty

  attr_accessor :analysis
  
  def initialize(url)
    @response = nil
    @play = nil
    @analysis = {}
    @url = url
  end

  def analyze
    download_play.xpath('//SCENE//SPEECH').each do |node|
      name = node.children.search('SPEAKER').text
      unless name.eql?('all')
        @analysis[name] ||= 0
        @analysis[name] = @analysis[name] + node.children.search('LINE').size
      end
    end
  end

  def print_all
    @analysis.each do |k, v|
      puts "#{v}\t#{k}"
    end
  end

  def download_play
    @response ||= self.class.get @url
    Nokogiri::XML(@response.body)
  end
end
