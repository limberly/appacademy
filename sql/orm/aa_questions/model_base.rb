require_relative 'questions_database.rb'

class Modelbase
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      "#{self.table_name}"
    WHERE
      id = ?
  SQL
  self.new(data.first)
  end
end