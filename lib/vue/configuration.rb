module Vue
  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  class Configuration
    def initialize
      @generators = Generators.new
    end

    def generators(&block)
      if block_given?
        @generators = Generators.new(&block)
      else
        @generators
      end
    end

    class Generators
      attr_accessor :styles, :syntax, :packs, :single_file_component

      def initialize
        @styles = ActiveSupport::OrderedOptions.new
        @styles.lang = :scss
        @styles.scoped = true
        @syntax = :es2015
        @packs = true
        @single_file_component = true
        yield self if block_given?
      end
    end
  end
end
