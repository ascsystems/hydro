class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :first_name
      t.string :last_name
      t.string :discipline
      t.string :image_path
      t.text :bio

      t.timestamps
    end
  end
end
