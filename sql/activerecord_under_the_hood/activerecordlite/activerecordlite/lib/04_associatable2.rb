require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...

    define_method(name) {
      through_options = self.class.assoc_options[through_name]
      source_options = self.class.assoc_options[through_name].model_class.assoc_options[source_name]
      
      data = DBConnection.execute(<<-SQL)
        SELECT
          #{source_options.table_name}.*
        FROM
          #{self.class.table_name}
        JOIN
          #{through_options.table_name}
        ON
          #{self.class.table_name}.#{through_options.foreign_key} = #{through_options.table_name}.#{through_options.primary_key}
        JOIN
          #{source_options.table_name}
        ON
        #{through_options.table_name}.#{source_options.foreign_key} = #{source_options.table_name}.#{source_options.primary_key}
        WHERE
          #{self.class.table_name}.id = #{self.id}
      SQL
      source_options.class_name.constantize.new(data[0])

    }
  end
end
