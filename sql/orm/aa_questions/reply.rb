require_relative 'questions_database'
require_relative 'model_base'
require_relative 'user'
require_relative 'question'

class Reply < Modelbase
  attr_accessor :fname, :lname
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @author_id = options['author_id']
    @body = options['body']
    @parent_reply_id = options['parent_reply_id']
  end

  def self.table_name
    "replies"
  end

  def self.find_by_user_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = :id
    SQL
    
    Reply.new(data.first)
  end

  def self.find_by_question_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = :id
    SQL
  
    data.map {|q| Reply.new(q)}
  end

  def author
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id: @author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = :author_id
    SQL

    User.new(data.first)
  end

  def question
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: @question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = :question_id
    SQL

    Question.new(data.first)
  end

  def parent_reply
    data = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id: @parent_reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = :parent_reply_id
  SQL

  Reply.new(data.first)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, id: @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = :id
  SQL

  Reply.new(data.first)
  end

  def save
    if @id
      puts "updating..."
      update
    else
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @body, @parent_reply_id)
        INSERT INTO
          replies (question_id, author_id, body, parent_reply_id)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update
    raise "This reply doesn't exist in database" if !@id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @body, @parent_reply_id, @id)
      UPDATE
        replies
      SET
        question_id = ?, author_id = ?, body = ?, parent_reply_id = ?
      WHERE
        id = ?
    SQL
  end
end