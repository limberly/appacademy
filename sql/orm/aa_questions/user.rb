require_relative 'questions_database'
require_relative 'model_base'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'

class User < Modelbase
  attr_accessor :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.table_name
    "users"
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = :fname
      AND
        lname = :lname
    SQL

    User.new(data.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, id: @id)
      SELECT
       avg(likes) as num_likes
      FROM (
        SELECT
          questions.id, count(question_likes.user_id) as likes
        FROM
          users
        JOIN
          questions ON users.id = questions.author_id
        JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          users.id = :id
        GROUP BY
          questions.id
      ) AS counted
    SQL

    data.first['num_likes']
  end

  def save
    if @id
      puts "#{@fname} #{@lname} exists in database, updating..."
      update 
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update
    raise "#{@fname} #{@lname} does not exist in database" if !@id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end
end
