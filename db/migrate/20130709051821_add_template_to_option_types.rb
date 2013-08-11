class AddTemplateToOptionTypes < ActiveRecord::Migration
  def change
    add_column :option_types, :template, :string
  end
end
