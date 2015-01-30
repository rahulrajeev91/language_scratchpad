class Tree
  attr_accessor :children, :node_name
  def initialize(name, children=[])
    @children = children
    @node_name = name
  end

  def visit_all(indent="", &block)
    visit indent, &block
    if indent == ""
      indent = 16.chr
    end
    children.each {|c| c.visit_all "  "+indent, &block}
  end

  def visit(indent="", &block)
    block.call self, indent
  end
end

ruby_tree = Tree.new("ruby", [
  Tree.new("hello", [
    Tree.new("world"),
    Tree.new("hola"),
  ]), 
  Tree.new("foo", [
    Tree.new("bar"),
  ])
])

puts "\nvisiting a node"
ruby_tree.visit {|node, indent| print indent+node.node_name+"\n"}

puts "\nvisiting whole tree"
ruby_tree.visit_all {|node, indent| print indent+node.node_name+"\n"}
