module ApplicationHelper

  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def image_category category
    link_to image_tag(category.image, width: "#{Settings.category.image_width}",
      height: "#{Settings.category.image_height}"), category
  end

  def words_category category
    content = link_to(category.name, category) << content_tag(:p, category.title)
    content_tag :h2, content
  end

  def content_category category_counter, category
    category_counter % 2 == 0 ? image_category(category) : words_category(category)
  end
end
