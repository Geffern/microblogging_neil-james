class CreateDatabase < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
  		t.string :uname
  		t.string :email
  		t.string :password
  		t.timestamps
  	end
  	create_table :posts do |t|
  		t.string :title
  		t.text :body
  		t.belongs_to :user, foreign_key: true
  		t.timestamps
  		# t.datetime created_at
  		# t.datetime updated_at
  	end
  end
end
