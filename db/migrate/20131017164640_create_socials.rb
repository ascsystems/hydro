class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :permalink
      t.string :avatar
      t.datetime :article_date
      t.datetime :active_date
      t.string :title
      t.string :author
      t.string :thumbnail
      t.string :shortlink
      t.text :description
      t.string :quote
      t.string :video
      t.string :image_caption

      t.timestamps
    end
  end
end
