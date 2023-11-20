# frozen_string_literal: true

class CreateStripeTables < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :content
      t.integer :price
      t.string :product_id
      t.string :price_id
      t.timestamps
    end

    create_table :subscriptions do |t|
      t.belongs_to :user, foreign_key: { on_delete: :cascade }
      t.belongs_to :product, foreign_key: { on_delete: :cascade }
      t.string :status
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.string :interval
      t.string :subscription_id
      t.timestamps
    end

    add_column :users, :customer_id, :string
  end
end
