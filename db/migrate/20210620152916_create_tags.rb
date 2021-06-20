class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      # Error: StandardError: An error has occurred, this and all later migrations canceled:
      # enable_extension('citext')

      # t.citext :name
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # add_index :tags, %i[name user_id], unique: true
  end
end
