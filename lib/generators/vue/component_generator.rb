module Vue
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc <<-DESC.strip_heredoc
      Description:
          Scaffold a Vue component into `components/` of your Webpacker source or asset pipeline.
          The generated component will include a basic layout to help with development.

      Examples:
          rails g vue:component form
      DESC

      class_option :single_file_component,
                   type: :boolean,
                   default: true,
                   desc: 'Output single-file component'

      class_option :styles_lang,
                   type: :string,
                   default: 'scss',
                   desc: 'Use custom css syntax, e.g. css, sass, scss'

      class_option :styles_scoped,
                   type: :boolean,
                   default: true,
                   desc: 'Scope styles to generated component'

      class_option :coffee,
                   type: :boolean,
                   default: false,
                   desc: 'Output coffeescript based component'

      class_option :pack,
                   type: :boolean,
                   default: true,
                   desc: 'Generate pack for the component'

      class_option :vuex,
                   type: :boolean,
                   default: false,
                   desc: 'Add vuex support for component pack'

      def call
        component_file_path = File.join(
          component_target_dir,
          "#{component_name}.vue"
        )

        template("component.vue", component_file_path)

        if options[:pack]
          pack_file_path = File.join(
            pack_target_dir,
            "#{file_name.dasherize}.js"
          )

          template("pack.js", pack_file_path)
        end
      end

      private

      def component_name
        file_name.camelize
      end

      def webpacker?
        defined?(Webpacker)
      end

      def webpack_config
        if Webpacker.respond_to?(:config)
          Webpacker.config
        else
          Webpacker::Configuration
        end
      end

      def component_target_dir
        if webpacker?
          webpack_config.source_path
                        .join('components')
                        .relative_path_from(::Rails.root)
                        .to_s
        else
          'app/assets/javascripts/components'
        end
      end

      def pack_target_dir
        if webpacker?
          webpack_config.source_path
                        .join('packs')
                        .relative_path_from(::Rails.root)
                        .to_s
        else
          'app/assets/javascripts/packs'
        end
      end

      def file_extension
        'vue'
      end

      def styles_lang
        options[:styles_lang] || vue_configuration.generators.styles.lang
      end

      def styles_scoped
        options[:styles_scope] || vue_configuration.generators.styles.scoped
      end

      def pack
        options[:pack] || vue_configuration.generators.packs
      end

      def vue_configuration
        ::Vue.configuration
      end
    end
  end
end
