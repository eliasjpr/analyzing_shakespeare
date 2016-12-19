require './lib/play_analyzer'

macbeth_url = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
macbeth_analyzer = PlayAnalyzer.new(macbeth_url)
macbeth_analyzer.analyze
macbeth_analyzer.report
