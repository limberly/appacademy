require_relative 'questions_database'
require_relative 'model_base'
require_relative 'user'
require_relative 'question'

class QuestionFollow < Modelbase
  attr_accessor :user_id, :question_id
  
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.table_name
    "question_follows"
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = :question_id
    SQL

    data.map {|u| User.new(u)}
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = :user_id
    SQL

    data.map {|q| Question.new(q)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        question_id
      ORDER BY
        count(user_id) DESC
      LIMIT
       :n

    SQL
    data.map {|q| Question.new(q)}
    
  end
end