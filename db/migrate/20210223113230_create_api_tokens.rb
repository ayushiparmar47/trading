class CreateApiTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :api_tokens do |t|
      t.string :finnhub_api_token
      t.string :iexcloud_api_token

      t.timestamps
    end
  end
end
