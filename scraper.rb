# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Read in a page
page = agent.get("https://www.planningalerts.org.au/authorities/")

sentence = page.at("#content").search("p")[1].text
words = sentence.split(" ")

if words.count.eql? 54
  record = {
    date_scraped: Date.today.to_s,
    percentage_of_population_convered: words[3].delete("%").to_i,
    number_of_authorities: words[8].to_i
  }

  p record

  # # Write out to the sqlite database using scraperwiki library
  ScraperWiki.save_sqlite([:date_scraped], record)
else
  raise "Paragraph has changed"
end
