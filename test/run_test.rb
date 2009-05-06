require File.join(File.dirname(__FILE__), 'test_helper')

Dir.glob('test/test_*.rb') do |file|
  require file.sub(/\.rb$/, '')
end
