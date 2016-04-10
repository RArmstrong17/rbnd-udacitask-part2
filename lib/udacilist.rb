class UdaciList
  include Listable
  attr_accessor :title, :items

  def initialize(options={})
    @title = options[:title] || @title = 'Untitled List'
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @items.push TodoItem.new(description, options, @title) if type == "todo"
    @items.push EventItem.new(description, options, @title) if type == "event"
    @items.push LinkItem.new(description, options, @title) if type == "link"
    raise UdaciListErrors::InvalidItemType, "#{type} is not accepted as a type for the list." if type != 'todo' && type != 'event' && type != 'link'
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "The index is greater than the length of the list." if index > @items.length
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
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
      puts "#{position + 1}) #{item.details}"
    end
  end

  def change_priority(item, priority)
    todo_item = @items.find{|list_item| list_item.description == item} if item.is_a?(String)
    todo_item = @items[item - 1] if item.is_a?(Integer)
    todo_item.change_priority(priority)
  end


end
