class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username
      t.string :text
      t.string :twitter_tweet_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
