require_relative "system_file"

class Folder
  attr_reader :parent_folder, :size, :name, :contained_folders, :contained_files

  def initialize(name:, parent_folder:)
    @name = name
    @parent_folder = parent_folder
    @contained_folders = []
    @contained_files = []
    @size = 0
  end

  def find_folder(folder_name)
    @contained_folders.detect { _1.name == folder_name }
  end

  def find_or_generate_folder(folder_name:)
    potential_folder = find_folder(folder_name)
    return potential_folder if potential_folder

    folder = Folder.new(name: folder_name, parent_folder: self)
    @contained_folders << folder
    folder
  end

  def find_file(file_name)
    @contained_files.detect { _1.name == file_name }
  end

  def find_or_generate_file(file_name:, size:)
    potential_file = find_file(file_name)
    return potential_file if potential_file

    file = SystemFile.new(name: file_name, size: size)
    @contained_files << file
    increase_size(size)
    file
  end

  def increase_size(size)
    @size += size
    parent_folder&.increase_size(size)
  end
end
