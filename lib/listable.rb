module Listable

  def format_description
    "#{@description}".ljust(25)
  end

  def details
    if self.class == LinkItem
      format_description + "site name: " + format_name
    elsif self.class == TodoItem
      if Date.today.strftime("%D") == format_date
        TerminalNotifier.notify("#{self.description} in #{self.title} is due today.")
        format_description + "due: " + format_date + format_priority
      else
        format_description + "due: " + format_date + format_priority
      end
    elsif self.class == EventItem
      if Date.today.strftime("%D") == format_date
        TerminalNotifier.notify("#{self.description} in #{self.title} starts today.")
        format_description + "event dates: " + format_date
      else
        format_description + "event dates: " + format_date
      end
    end
  end

  def format_date
    if self.class == TodoItem
      @due ? @due.strftime("%D") : "No due date"
    elsif self.class == EventItem
      dates = @start_date.strftime("%D") if @start_date
      dates << " -- " + @end_date.strftime("%D") if @end_date
      dates = "N/A" if !dates
      return dates
    end
  end

end
