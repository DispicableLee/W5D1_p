class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if num <0 || num > @store.length
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if is_valid?(num)
    false
  end

  private

  def is_valid?(num)
    @store[num]
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any?{|e| e  == num}
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self[num] << num unless self[num].include?(num)
    resize! if count > num_buckets
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].any?{|e| e  == num}
  end

  def count 
    @store.flatten.count
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    self_store = store.flatten
    if count > num_buckets
      @store = Array.new(2*num_buckets){Array.new}
      self_store.each {|e| self.insert(e)}
    end
    # count = 0
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end
end

# int = ResizingIntSet.new

# int.insert(50)

# p int

# int.resize!

# p int.store