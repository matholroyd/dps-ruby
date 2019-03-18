class CreateDpsEngineAdminUsersNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :dps_engine_admin_users_nodes do |t|
      t.string :title

      t.timestamps
    end
  end
end
