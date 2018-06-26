module Vue
  module ControllerHelper
    extend ActiveSupport::Concern

    class_methods do
      def pack_tag_for(pack = nil)
        pack ||= 'world'
        puts "hello #{pack}"
      end
    end
  end
end
