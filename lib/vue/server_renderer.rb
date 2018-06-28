module Vue
  class ServerRenderer
    def initialize
      vue_source = File.read(Rails.root.join('node_modules', 'vue', 'dist', 'vue.js'))
      vue_renderer_source = File.read(Rails.root.join('node_modules', 'vue-server-renderer', 'basic.js'))
      server_rendering_pack = File.read(Rails.root.join(File.join(Webpacker.config.public_path, Webpacker.manifest.lookup('server_rendering.js'))))

      @context = ExecJS.compile(vue_source + vue_renderer_source + server_rendering_pack)
    end

    def render(component_name, props)
      vue_component_string(component_name, props)
    end

    private

    def vue_component_string(component_name, props)
      js_string = <<-JS
        (function () {
          var component = new Vue({
            render: h => {
              console.log(h)
              return h(#{component_name}, { attrs: { 'data-props': JSON.stringify(#{props.to_json}) }, props: #{props.to_json} })
            }
          })

          var html = null

          renderVueComponentToString(component, (err, res) => {
            html = res
          })

          return html
        })()
      JS

      @context.eval(js_string).html_safe
    rescue ExecJS::ProgramError => e
      Rails.logger.debug(e.message)
    end
  end
end
