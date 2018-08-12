class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    @tail.prev.next = node
    node.next = @tail
    node.prev = @tail.prev
    @tail.prev = node
    node
  end

  def update(key, val)
    each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end

    nil
  end

  def each(&prc)
    node = @head.next
    while node != @tail
      prc.call(node)
      node = node.next
    end
  end

  def to_s
    reduce([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
