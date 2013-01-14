module ApplicationHelper
  def title
    base_title = "PadOnRails"
    if @title.nil?
      base_title
    else
      if current_page?(login_path)
      "#{base_title}"
      else
      "#{base_title} | #{@title}"
      end
    end 
  end
  
  def main_title
    base_title = "PadOnRails"
    if @title.nil?
      base_title
    else
      @title
    end
  end
  def link_to_remove_fields(name, f, link="this")
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(#{link})")
  end
  
  def link_to_add_fields(name, f, association, link="this")
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(#{link}, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
