require_relative 'questions_database'
require_relative 'model_base'
require_relative 'user.rb'

class QuestionLike < Modelbase
  attr_accessor :fname, :lname
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']

  end

  def self.table_name
    "question_likes"
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = :question_id
    SQL
    data.map {|u| User.new(u)} 
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
    SELECT
      count(*) as counted
    FROM
      question_likes
    WHERE
      question_id = :question_id
  SQL
  data.first['counted']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = :user_id
    SQL

    data.map {|q| Question.new(q)}
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        questions.*, count(question_likes.user_id)
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      GROUP BY
        question_likes.question_id
      ORDER BY
        count(question_likes.user_id)
      LIMIT
        :n
    SQL

  data.map {|q| Question.new(q)}
  end
end