module Vue
  class ControllerRenderer
    include Vue::ViewHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper

    attr_accessor :output_buffer

    def initialize(options = {})
      controller = options[:controller]
    end

    def call(component_name, options, &block)
      props = options.fetch(:props, {})
      options = default_options.merge(options)

      vue_component(component_name, props, options, &block)
    end

    private

    def default_options
      {}
    end
  end
end
