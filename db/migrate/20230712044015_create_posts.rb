create_table :posts do |t|
  t.string :title
  t.text :text
  t.integer :comments_counter
  t.integer :likes_counter
  t.timestamps # this will crate uopdated_at and created_at columns
  t.references :author, foreign_key: { to_table: 'users' } # this will create author_id and a corresponding index  (but students can also add column and index in separate commands)
end
