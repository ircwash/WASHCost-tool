class Selection::ToolSelection
  include ActiveAttr::Model

  attribute :tool_name
  attribute :tool_type
  attribute :lang

  def index
    "#{tool_name}#{tool_type}".to_i(2)
  end
end
