class Heap
  def initialize(&block)
    @compare_fn = block || lambda { |x, y| x < y }
    @size = 0
    @arr = []
  end

  def size
    @size
  end
  alias_method :length, :size

  def push(n)
    @arr << n
    @size += 1
    up(@size-1)
  end
  alias_method :<<, :push

  def pop
    swap(0, @size-1)
    down(0)

    @size -= 1
    @arr.pop
  end

  private

  def up(idx)
    while true
      parent = (idx-1) / 2
      break if parent < 0 || parent == idx || @compare_fn[@arr[parent], @arr[idx]]
      swap(parent, idx)
      idx = parent
    end
  end

  def swap(idx1, idx2)
    @arr[idx1], @arr[idx2] = @arr[idx2], @arr[idx1]
  end

  def down(idx)
    i = idx
    while true
      left_child = 2*i+1
      break if left_child >= @size-1 || left_child < 0

      next_idx = left_child
      right_child = left_child+1

      next_idx = right_child if right_child < @size-1 && @compare_fn[@arr[right_child], @arr[left_child]]

      break unless @compare_fn[@arr[next_idx], @arr[i]]

      swap(i, next_idx)

      i = next_idx
    end

    i > idx
  end
end
