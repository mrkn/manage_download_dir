require 'fileutils'

require 'test/unit'

require 'rubygems'
require 'redgreen'
require 'shoulda'

basedir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(basedir, 'bin'))
$:.unshift(File.join(basedir, 'lib'))
$:.unshift(File.join(basedir, 'test'))
