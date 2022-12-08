class SystemFile
  attr_reader :size, :name

  def initialize(name:, size:)
    @name = name
    @size = size
  end
end
