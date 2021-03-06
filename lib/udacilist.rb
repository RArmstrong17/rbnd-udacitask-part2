class UdaciList
  include Listable
  attr_accessor :title, :items

  def initialize(options={})
    @title = options[:title] || @title = 'Untitled List'
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @items.push TodoItem.new(type, description, options, @title) if type == "todo"
    @items.push EventItem.new(type, description, options, @title) if type == "event"
    @items.push LinkItem.new(type, description, options, @title) if type == "link"
    raise UdaciListErrors::InvalidItemType, "#{type} is not accepted as a type for the list." if type != 'todo' && type != 'event' && type != 'link'
  end

  def delete(*indices)
    to_delete = *indices
    to_delete.sort!.reverse!
    raise UdaciListErrors::IndexExceedsListSize, "The index is greater than the length of the list." if to_delete.first > @items.length
    @items.delete_if.with_index{|_, index| to_delete.include? index + 1}
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1})#{item.details}"
    end
  end

  def filter(class_type)
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    filter = @items.find_all{|list_items| list_items.is_a?(EventItem)} if class_type == 'event'
    filter = @items.find_all{|list_items| list_items.is_a?(LinkItem)} if class_type == 'link'
    filter = @items.find_all{|list_items| list_items.is_a?(TodoItem)} if class_type == 'todo'
    filter.each_with_index do |item, position|
      puts "#{position + 1})#{item.details}"
    end
  end

  def change_priority(item, priority)
    todo_item = @items.find{|list_item| list_item.description == item} if item.is_a?(String)
    todo_item = @items[item - 1] if item.is_a?(Integer)
    raise UdaciListErrors::PriorityItemError, "Wrong item type, item is not a todo." if !todo_item.is_a?(TodoItem)
    todo_item.change_priority(priority)
  end


end
