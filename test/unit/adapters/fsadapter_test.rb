load 'lib/fsmapper/adapters/fsadapter.rb'

class TestFsMapper < Test::Unit::TestCase
  def setup
    load_default_file_structure
  end

  def test_hash_structure
    fs_adapter = FsAdapter.new(TEST_FS_ROOT)
    assert_equal(default_file_structure, fs_adapter.to_hash)
  end

  def teardown
    destroy_default_file_structure
  end
end
