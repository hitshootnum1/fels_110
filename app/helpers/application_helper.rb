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
    path = category.image? ? category.image : Settings.category.default_image_path
    image_tag(path, width: "#{Settings.category.image_width}",
      height: "#{Settings.category.image_height}")
  end

  def image_avatar user, size
    path = user.avatar? ? user.avatar : Settings.user.avatar_default_path
    image_tag path, size: "#{size}"
  end

  def words_category category
    content = link_to(category.name, category) << content_tag(:p, category.title)
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

  def render_header
    render admin_user? ? "shared/layout/header/admin" : "shared/layout/header/user"
  end

  def answer_class_attr disable_check, answer, answer_ids
    class_attr = "label label-"
    if disable_check && answer.correct? && answer_ids.include?(answer.id)
      class_attr << "success"
    elsif disable_check && answer_ids.include?(answer.id)
      class_attr << "danger"
    else
      class_attr << "default"
    end
    content_tag :span, answer.content, class: "#{class_attr}"
  end
end
