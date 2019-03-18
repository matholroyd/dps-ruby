class CreateDpsEngineArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :dps_engine_articles do |t|
      t.string :title

      t.timestamps
    end
  end
end
