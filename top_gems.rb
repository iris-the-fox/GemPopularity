require 'httparty'
require 'nokogiri'
class GemPopularity
  include HTTParty
  base_uri 'https://github.com/'
  attr_accessor :used, :name, :watch , :star, :fork

  def initialize(gem_name)
  	@name = gem_name
    page = HTTParty.get("https://github.com/#{gem_name}/#{gem_name}")
    doc = Nokogiri::HTML(page.body)
    @watch = doc.css('.social-count')[0].text.strip
    @star = doc.css('.social-count')[1].text.strip
    @fork = doc.css('.social-count')[2].text.strip

  end
end

sinatra = GemPopularity.new('sinatra')

# Вывод вида: rails    | used by xxx | watched by xx |  x stars | xx forks | xx contributors | x issues |
puts "#{sinatra.name} | watched by #{sinatra.watch} | #{sinatra.star} stars | #{sinatra.fork} forks "