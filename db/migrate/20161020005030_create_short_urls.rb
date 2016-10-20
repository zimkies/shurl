class CreateShortUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :short_urls do |t|
      t.string :code, index: true
      t.string :url

      t.timestamps
    end
  end
end
