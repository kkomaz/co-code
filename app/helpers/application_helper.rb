module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code,language)
      CodeRay.scan(code,language).div
    end
  end

  def markdown(content)
    code_rayified = CodeRayify.new(:filter_html => true,
                                   :hard_wrap => true)
    options = {
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      autolink: true,
      lax_html_blocks: true
    }
    markdown_to_html = Redcarpet::Markdown.new(code_rayified, options)
    markdown_to_html.render(content).html_safe
  end
  
end
