class AddCityAndAqiThresholdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :city, :string
    add_column :users, :aqi_threshold, :integer
  end
end
