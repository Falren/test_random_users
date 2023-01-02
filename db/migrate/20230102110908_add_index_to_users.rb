class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def up
    enable_extension('btree_gin')
    enable_extension('pg_trgm')
    execute <<-SQL
      CREATE INDEX users_data_nat_idx ON users USING gin(lower((data->>'nat')), (data -> 'dob' ->> 'age'));
      CREATE INDEX users_data_name_first_idx ON users USING gin(lower((data -> 'name' ->> 'first')) gin_trgm_ops);
    SQL
  end

  def down
    disable_extension('pg_trgm')
    disable_extension('btree_gin')
    execute <<-SQL
      DROP INDEX IF EXISTS users.users_data_nat_idx;
      DROP INDEX IF EXISTS users.users_data_name_first_idx;
    SQL
  end
end
