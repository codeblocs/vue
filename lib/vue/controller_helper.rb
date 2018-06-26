module Vue
  module ControllerHelper
    extend ActiveSupport::Concern

    class_methods do
      def pack_tag_for(pack = nil)
        before_action { @pack ||= pack.to_s }
      end
    end
  end
end
