require "bb/facebook/core.rb"
require "bb/facebook/graph.rb"

module BB
  module Facebook
    def self.graph=(graph)
      @graph = graph
    end

    def self.graph
      @graph
    end
  end
end