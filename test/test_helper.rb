require 'yaml'
require 'fileutils'

DEFAULT_FILENAME = 'test/helpers/default_filesystem.yml'
TEST_FS_ROOT = 'test/tmp'

def default_file_structure
  {"root" => YAML::load(File.read(DEFAULT_FILENAME))}
end

def load_default_file_structure
  file_structure = default_file_structure
  create_file_structure file_structure
end

def create_file_structure file_structure, current_dir = TEST_FS_ROOT
  file_structure = [file_structure].flatten
  file_structure.each do |fs_node|
    if fs_node.is_a? Array
      create_file_structure fs_node, current_dir
    elsif fs_node.is_a? Hash
      fs_node.each do |dir_name, dir_content|
        new_dir = File.join(current_dir, dir_name)
        FileUtils.mkpath(new_dir)
        create_file_structure(dir_content, new_dir)
      end
    elsif fs_node.is_a? String
      new_file = File.join(current_dir, fs_node)
      FileUtils.touch(new_file)
    end
  end
end

def destroy_default_file_structure
  FileUtils.rm_r TEST_FS_ROOT
end
