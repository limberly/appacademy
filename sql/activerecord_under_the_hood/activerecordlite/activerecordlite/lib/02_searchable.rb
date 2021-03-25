require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    keys = params.keys
    vals = params.values
    keys = keys.join("= ? AND ") + "=?"
    data = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{keys}
    SQL

    self.parse_all(data)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
