require 'net/http'
require './lib/play_downloader'

RSpec.describe PlayDownloader do
  let(:content) { File.read('./spec/xml_files/play_example.xml') }
  let(:valid_url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }
  let(:invalid_url) { 'htt://www.bad_url.com' }

  describe '.download' do
    context 'when is valid url' do
      before do
        downloader = instance_double('PlayDownloader')
        allow(downloader).to receive(:fetch).and_return(content)
      end

      it 'fetches a request successfully' do
        response = PlayDownloader.fetch valid_url
        expect(response).to be_an_instance_of(String)
        expect(response).to eq content
      end
    end

    context 'when is invalid url' do
      let(:bad_response) {
        'Failed to open TCP connection to www.bad_url.com:80 (getaddrinfo: nodename nor servname provided, or not known)'
      }

      it 'raises exception' do
        response = PlayDownloader.fetch invalid_url
        expect(response).to eq bad_response
      end
    end
  end
end
