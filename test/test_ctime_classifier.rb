require File.join(File.dirname(__FILE__), "test_helper")

require 'ctime_classifier'

class TestCTimeClassifier < Test::Unit::TestCase
  def setup
    @target_dir = 'test_target'
  end

  context "when the target directory is found" do
    setup do
      FileUtils.mkdir_p @target_dir
    end

    should "be able to instantiation with scanning the target directory" do
      ctcl = CTimeClassifier.scan(@target_dir)
      assert ctcl.kind_of?(CTimeClassifier)
    end

    context "when there are no files and directories in the target directory" do
      setup do
        @ctcl = CTimeClassifier.scan(@target_dir)
      end

      should "have no associations" do
        assert_equal 0, @ctcl.length
      end
    end

    teardown do
      FileUtils.rm_rf @target_dir
    end
  end

  context "when the target directory is not found" do
    should "raise the RuntimeError if it is instantiated by the scan class method" do
      #
    end
  end

  def teardown
  end
end
