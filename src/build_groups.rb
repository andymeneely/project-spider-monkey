require 'set'

module Squib
  class Deck

    def group mode, &block
      block.yield if groups.include? mode
    end

    def enable_group mode
      groups
      @build_groups << mode
    end

    def disable_group mode
      groups
      @build_groups.delete mode
    end

    def groups
      @build_groups ||= Set.new.add(:all)
    end

  end
end
