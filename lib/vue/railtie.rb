require 'rails'

module Vue
  class Railtie < ::Rails::Railtie
    initializer 'vue.setup_controller_helpers', after: :load_config_initializers, group: :all do
      ActiveSupport.on_load(:action_controller) do
        include ::Vue::ControllerHelper
      end
    end

    initializer 'vue.setup_view_helpers', after: :load_config_initializers, group: :all do
      ActiveSupport.on_load(:action_view) do
        include ::Vue::ViewHelper
      end
    end

    initializer 'vue.add_component_renderer', group: :all do
      ActionController::Renderers.add :vue_component do |component_name, options|
        renderer = ::Vue::ControllerRenderer.new(controller: self)
        html = renderer.call(component_name, options)
        render_options = options.merge(inline: html)
        render(render_options)
      end
    end
  end
end
