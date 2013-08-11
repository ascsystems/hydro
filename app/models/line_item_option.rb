class LineItemOption < ActiveRecord::Base
  attr_accessible :line_item_id, :option_id, :option_name

  belongs_to :line_item

end
