class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id
  
  has_many :responses,
    through: :answer_choices,
    source: :responses

    def results
      counting = self.answer_choices.select(:text, "count(responses.id) as num_cnt")
        .left_outer_joins(:responses).group('answer_choices.id')

      counting.inject({}) do |result, cnt|
        result[cnt.text] = cnt.num_cnt
        result
      end
    end
end