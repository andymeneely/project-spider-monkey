module Squib
  module Refinements
    refine Array do
      def non_nil_indices
        each.with_index.map { |x, i| x.nil? ? nil : i }.compact
      end

      def index_lookups
        each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}
      end
    end
  end
end
