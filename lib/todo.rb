class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :title

  def initialize(description, options={}, title)
    @title = title
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]): options[:due]
    @priority = options[:priority]
    raise UdaciListErrors::InvalidPriorityValue, "#{@priority} is not an acceptable priority level. (low, medium, high)" if @priority != 'low' && @priority != 'medium' && @priority != 'high' && !!@priority
  end

  def format_priority
    value = "⇧" if @priority == "high"
    value = "⇨" if @priority == "medium"
    value = "⇩" if @priority == "low"
    value = "" if !@priority
    return " " + value.colorize(:white).on_red
  end

  def change_priority(priority)
    @priority = priority
  end
end
