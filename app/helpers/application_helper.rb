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
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    )
    markdown.render(content).html_safe
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group date", :id => "datetimepicker") do
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group date", :id => "datetimepicker") do
          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A", :placeholder => "Set date & time") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end

