#! /usr/bin/env ruby
# coding: utf-8

def list_directory(dir)
  Dir["#{dir}/*"]
end

if __FILE__ == $0
  nil
end
