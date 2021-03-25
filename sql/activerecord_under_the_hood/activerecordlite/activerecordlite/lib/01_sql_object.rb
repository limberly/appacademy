require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    data = DBConnection.execute2(<<-sql)
      SELECT
        *
      FROM
        #{self.table_name}
    sql
    @columns = data[0].map(&:to_sym)
  end

  def self.finalize!
    self.columns
    @attributes ||= {}
    @columns.each do |column|
      define_method(column) do 
        self.attributes[column]
      end

      define_method(column.to_s+'=') do |val|
        self.attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
    @table_name
  end

  def self.table_name
    # ...
    @table_name || self.to_s.tableize
  end

  def self.all
    # ...
    data = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    # ...
    
    results.map do |hash|
      self.new(hash)
    end
  end

  def self.find(id)
    # ...
    data = DBConnection.execute(<<-SQL, id)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    self.parse_all(data)[0]
  end

  def initialize(params = {})
    # ...
    params.each do |name, value|
      name = name.to_sym
      name_s = name.to_s
      if self.class.columns.include?(name)
        self.send(name_s+'=', value)
      else
        raise "unknown attribute '#{name_s}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map {|attr| self.send(attr)}
  end

  def insert
    # ...
    col_names = self.class.columns.join(',')
    question_marks = (["?"]*attribute_values.length).join(',')
    # debugger
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    col_names = self.class.columns.map(&:to_s)
    col_names.delete('id')
    col_names = col_names.join(" = ?,") +" =?"
    id_val = self.send(:id)
    attr_val = attribute_values
    attr_val.shift
    DBConnection.execute(<<-SQL, *attr_val, id_val)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    self.id ? update : insert
  end
end
