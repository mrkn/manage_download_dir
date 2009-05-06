require File.join(File.dirname(__FILE__), "test_helper")

require 'daily_classifier'

class TestDailyClassifier < Test::Unit::TestCase
  context "without any files and directories" do
    setup do
      @target_dir = 'test_target'
      FileUtils.mkdir_p @target_dir
    end

    should "be there the test_target directory" do
      assert File.directory?('test_target')
    end

    should "not list any files and directories" do
      list = list_directory(@target_dir)
      assert list.empty?
    end

    context "with a file" do
      setup do
        @file1 = File.join(@target_dir, 'file1')
        open(@file1, 'w') {}
      end

      should "be there a file named '#{@file1}'" do
        assert File.file?(@file1)
      end

      should "list a file named '#{@file1}'" do
        list = list_directory(@target_dir)
        assert_equal 1, list.length
        assert_equal @file1, list[0]
      end

      context "with more files" do
        setup do
          @files = 2.upto(10).inject([]) do |a, x|
            fn = File.join(@target_dir, "file#{x}")
            open(fn, 'w') {}
            a + [fn]
          end
        end

        should "list files in the target directory" do
          list = list_directory(@target_dir)
          assert_equal @files.length + 1, list.length
          assert [@a_files, *@files], list
        end

        teardown do
          @files.each {|fn| FileUtils.rm_f fn }
        end
      end

      teardown do
        FileUtils.rm_f @file1
      end
    end

    teardown do
      FileUtils.rm_rf @target_dir
    end
  end
end
