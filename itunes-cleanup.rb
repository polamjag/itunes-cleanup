require 'nokogiri'
require 'uri'

if ARGV.size != 2
  puts <<-EOS
usage: bundle exec cleanup-itunes.rb <path to iTunes Library.xml> <path to target iTunes Media path>

example: bundle exec cleanup-itunes.rb "~/Music/iTunes/iTunes Library.xml" "~/Music/iTunes/iTunes Media/Music/"
  EOS
  exit 1
end

itl = open(ARGV[0]).read # iTunes Library.xml
target_path = File.expand_path(ARGV[1])

doc = Nokogiri::XML itl

itunes_medium = doc.xpath("/plist/dict/key[. = 'Tracks']/following-sibling::*[1]/dict/key[. = 'Location']/following-sibling::*[1]/text()").map do |i|
  URI.decode URI.parse(i.text).path
end

puts "Detected #{itunes_medium.size} files in iTunes Library.xml"

itunes_files = []
Dir.chdir target_path do
  itunes_files = Dir.glob("**/*.{mp3,m4a,m4v,wav,mp4,aac,aif,aiff,mov,mpg}")
end

puts "Detected #{itunes_files.size} files in iTunes Media directory"

itunes_files.map! do |i|
  i = File.join(target_path, i)
end

delete_target = (itunes_files - itunes_medium)

puts "Deleting #{delete_target.size} files ..."

delete_target.each_with_index do |f, i|
  puts "  -> Delete (#{i}/#{delete_target.size}): #{f}"
  File.delete f
end

puts "Done"

