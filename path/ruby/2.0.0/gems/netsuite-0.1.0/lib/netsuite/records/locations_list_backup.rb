module NetSuite
  module Records
    class LocationsList
      include Namespaces::PlatformCore

      def initialize(attributes = {})

        case attributes[:location]
        when Hash
          locations << Location.new(attributes[:location])
        when Array
          attributes[:location].each { |location| locations << Location.new(location) }
        end
      end

      def <<(location)
        @locations << location
      end

      def locations
        @locations ||= []
      end

      def to_record
        #rec = super
	#rec
#	locations.map do |location|
          { "#{record_namespace}:item" => location.map.(&:to_record) }
#       end
      end

    end
  end
end
