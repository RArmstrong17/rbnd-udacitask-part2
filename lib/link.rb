class LinkItem
  include Listable
  attr_reader :description, :site_name, :title

  def initialize(url, options={}, title)
    @title = title
    @description = url
    @site_name = options[:site_name] || @description.delete('https://','http://').delete('www.').slice(0..-4)
  end

  def format_name
    @site_name ? @site_name : ""
  end

end
