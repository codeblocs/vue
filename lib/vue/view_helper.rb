module Vue
  module ViewHelper
    def vue_component(component_name, props, options = {}, &block)
      render_name = component_name.dasherize
      render_props = props.transform_keys { |key| key.to_s.dasherize }

      content_tag(
        render_name,
        'data-props': render_props.to_json
      ) do
        yield if block_given?
      end
    end
  end
end
