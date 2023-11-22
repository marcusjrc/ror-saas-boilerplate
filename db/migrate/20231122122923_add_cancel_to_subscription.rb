# frozen_string_literal: true

class AddCancelToSubscription < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :cancel_at_period_end, :boolean
  end
end
