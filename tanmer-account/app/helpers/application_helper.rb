module ApplicationHelper

  def avatar_image_tag(user, class_name: '')
    image_tag(user.image || 'blank.png', class: "avatar #{class_name}")
  end

  def sidebar_link_tag(title, url, options={})
    content_tag :li, class: "#{'active' if request.path == url}" do
      link_to title, url, options
    end
  end

  def simple_form_error_messages(simple_form)
    if simple_form.object && simple_form.object.respond_to?(:errors) && (base_errors=simple_form.object.errors[:base]).any?
      content_tag(:div, class: 'bs-callout bs-callout-danger') do
        base_errors.map do |msg|
          content_tag(:span, msg, class: 'text-danger')
        end.join.html_safe
      end
    end
  end

  def render_api_json(data)
    render json: data.slice(:code, :code_name, :message, :data)
  end
end
