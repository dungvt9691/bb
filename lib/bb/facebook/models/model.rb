module BB
  module Facebook
    class Model
      def initialize(attributes)
        attributes.each do |key, value|
          send("#{key.to_s}=", value) rescue false
        end
      end

      def self.fields
        self.attr_readers.map{|atr| atr.to_s}
      end

      def to_sym
        self.instance_values.symbolize_keys!
      end

      # check that the attributes specified in args exist and is not nil
      def requires(*args)
        missing = missing_attributes(args)
        if missing.length == 1
          raise(ArgumentError, "#{missing.first} is required for this operation")
        elsif missing.any?
          raise(ArgumentError, "#{missing[0...-1].join(", ")} and #{missing[-1]} are required for this operation")
        end
      end

      def requires_one(*args)
        missing = missing_attributes(args)
        return unless missing.length == args.length
        raise(ArgumentError, "#{missing[0...-1].join(", ")} or #{missing[-1]} are required for this operation")
      end

      def requires_only(*args)
        missing = missing_attributes(args)
        return if missing.length == (args.length - 1)
        raise(ArgumentError, "Only support one in #{args[0...-1].join(", ")} and #{args[-1]}")
      end

      def self.symbolize_keys!(h)
        Hash[h.map{|(k,v)| [k.to_sym,v]}]
      end

      def as_json
        self.instance_values
      end

      protected

      def missing_attributes(args)
        missing = []
        args.each do |arg|
          missing << arg unless send("#{arg}")
        end
        missing
      end
    end
  end
end