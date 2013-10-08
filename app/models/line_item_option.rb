class LineItemOption < ActiveRecord::Base
  attr_accessible :line_item_id, :option_id, :option_name, :option_type, :option_type_id

  belongs_to :line_item

end
