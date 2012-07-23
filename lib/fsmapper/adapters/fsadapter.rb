class FsAdapter
  def initialize root
    @fs_hash = {}
    @fs_hash = load_dir root
  end

  def load_dir dir
    dir_path = File.join(dir, "**", "*")
    files_list = Dir[dir_path]
    new_hash = Hash.new{|h,k| h[k] = []}
    files_list.each do |filename|
      if File.directory? filename
        add_dir(new_hash, filename.sub(/^#{dir}\//, ""))
      elsif File.file? filename
        add_file(new_hash, filename.sub(/^#{dir}\//, ""))
      end
    end
    new_hash
  end

  def add_dir hash, dirname
    dirs = dirname.split(File::SEPARATOR)
    cur_node = hash[dirs.first]
    dirs[1..-1].each do |dir|
      found_node = cur_node.find{|node| node.is_a?(Hash) && node.keys.include?(dir)}
      if found_node
        cur_node = found_node[dir]
      else
        new_node = {dir => []}
        cur_node.push(new_node)
        cur_node = new_node[dir]
      end
    end
  end

  def add_file hash, dirname
    dirs = dirname.split(File::SEPARATOR)
    cur_node = hash[dirs.first]
    dirs[1..-2].each do |dir|
      found_node = cur_node.find{|node| node.is_a?(Hash) && node.keys.include?(dir)}
      if found_node
        cur_node = found_node[dir]
      else
        new_node = {dir => []}
        cur_node.push(new_node)
        cur_node = new_node[dir]
      end
    end
    cur_node.push(dirs.last)
  end

  def to_hash
    @fs_hash.dup
  end
end
