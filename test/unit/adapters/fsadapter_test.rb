require 'lib/fsmapper/adapters/fsadapter'
require 'test/unit'
require 'test/test_helper'

class TestFsMapper < Test::Unit::TestCase
  def setup
    load_default_file_structure
  end

  def test_hash_structure
    fs_adapter = FsAdapter.new(TEST_FS_ROOT)
    assert_equal(fs_adapter.to_hash, default_file_structure)
  end

  def teardown
    destroy_default_file_structure
  end
end
