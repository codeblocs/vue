module Vue
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Initialize Vue gem in Rails application'

      class_option :skip_git,
                   type: :boolean,
                   aliases: '-g',
                   default: false,
                   desc: 'Skip Git keeps'

      class_option :skip_server_rendering,
                   type: :boolean,
                   default: true,
                   desc: 'Don\'t generate files required for server rendering'

      class_option :skip_vuex
                   type: :boolean,
                   default: false,
                   desc: 'Don\'t generate vuex store files'

      def create_components_dir
        empty_directory File.join(components_dir, 'components')

        unless options[:skip_git]
          create_file File.join(components_dir, 'components/.gitkeep')
        end
      end

      def create_stores_dir
        empty_directory File.join(components_dir, 'stores')

        unless options[:skip_git]
          create_file File.join(components_dir, 'stores/.gitkeep')
        end
      end

      def create_vue_initializer
        initializer_path = 'config/initializers/vue.rb'

        template('vue.rb', initializer_path)
      end

      def setup_vue
        if webpacker?
          setup_vue_webpacker
        else
          setup_vue_sprockets
        end
      end

      private

      def setup_vue_webpacker

      end

      def setup_vue_sprockets

      end

      def webpacker?
        defined?(Webpacker)
      end

      def webpack_source_path
        if Webpacker.respond_to?(:config)
          Webpacker.config.source_entry_path
        else
          Webpacker::Configuration.source_path.join(Webpacker::Configuration.entry_path)
        end
      end

      def javascript_dir
        if webpacker?
          webpack_source_path.relative_path_from(::Rails.root).to_s
        else
          'app/assets/javascripts'
        end
      end

      def components_dir
        if webpacker?
          Pathname.new(javascript_dir).parent.to_s
        else
          javascript_dir
        end
      end
    end
  end
end
