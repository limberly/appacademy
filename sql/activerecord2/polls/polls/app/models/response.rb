class Response < ApplicationRecord
  validate :not_duplicate_response
  validate :cannot_respond_to_own_poll
  
  belongs_to :answer_choice
  
  belongs_to :respondent,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id


  has_one :question,
    through: :answer_choice,
    source: :question


  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << 'Can\'t vote twice for question'
    end
  end

  def poll_author?
    poll_author = self.answer_choice.question.poll.user_id
    self.user_id == poll_author
  end

  def cannot_respond_to_own_poll
    if poll_author?
      errors[:user_id] << 'cannot respond to own poll'
    end
  end
end