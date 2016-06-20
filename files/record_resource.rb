#! /opt/puppetlabs/puppet/bin/ruby
require 'json'
require 'fileutils'
require 'digest/md5'

unless ARGV.size == 2
  puts "Usage: record_resource.rb <type> <title>"
  puts
  puts "  Record the resource type and the title in a JSON file"
  puts "  to be used by the manageonce resource type family."
  puts
  exit 1
end

FACTPATH = '/etc/puppetlabs/facter/facts.d'
DATAFILE = "#{FACTPATH}/manageonce.json"

# just in case
FileUtils.mkdir_p FACTPATH

type, title = ARGV
File.open(DATAFILE, 'w+') do |file|
  file.flock(File::LOCK_EX)

  data = JSON.parse(File.read(file)) rescue {'manageonce' => {}}
  meta = { 'timestamp' => Time.now }

  # we'll record extra data about some resource types
  case type
    when 'file'
      meta['md5'] = Digest::MD5.file(title).hexdigest if File.exist? title

  end

  data['manageonce'][type] = { title => meta }
  File.write(DATAFILE, JSON.pretty_generate(data))
end
