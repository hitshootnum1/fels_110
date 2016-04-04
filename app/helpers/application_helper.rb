module ApplicationHelper

  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def image_category category, options = {}
    options = {width: Settings.category.image_width,
      height: Settings.category.image_height}.merge(options)
    width = options[:width]
    height = options[:height]
    path = category.image? ? category.image : Settings.category.default_image_path
    image_tag path, width: "#{width}", height: "#{height}"
  end

  def words_category category
    content = link_to(category.name, user_category_path(category)) <<
      content_tag(:p, category.title)
    content_tag :h2, content
  end

  def content_category category_counter, category
    category_counter % 2 == 0 ? image_category(category) : words_category(category)
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "#",
      onclick: "remove_fields(this); return false")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", onclick: "add_fields(this,
      \"#{association}\", \"#{j fields}\"); return false"
  end
end
