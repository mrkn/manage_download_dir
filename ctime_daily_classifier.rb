require 'date'
require 'fileutils'

REJECT_PATTERNS = [ /~\./,  ]

def main(dir)
  Dir.chdir(dir) do
    Dir.
    foreach('.').
    select {|x|
      not_today?(x) &&
      File.file?(x) &&
      File.writable_real?(x)
    }.
    inject({}) {|a, x|
      k = File.ctime(x).strftime('%Y-%m-%d')
      a[k] ||= []
      a[k].push(x)
      next a
    }.
    each {|k, fns|
      puts "mkdir -p #{k}"
      FileUtils.mkdir_p(k)
      fns.each{|fn|
        puts "mv #{fn} #{k}" unless reject? fn
        FileUtils.mv(fn, k) unless reject? fn
      }
    }
  end
end

def not_today?(fn)
  not today?(fn)
end

def today?(fn)
  c = File.ctime(fn)
  Date.today == Date.new(c.year, c.month, c.day)
end

def reject?(fn)
  if REJECT_PATTERNS.any?{|pat| fn =~ pat }
    puts "#{fn} REJECTED"
    return true
  end
  return false
end

download_dir = ARGV.shift || File.expand_path('~/Downloads')
main(download_dir)
