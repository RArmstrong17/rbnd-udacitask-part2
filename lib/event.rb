class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :title

  def initialize(description, options={}, title)
    @title = title
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

end
