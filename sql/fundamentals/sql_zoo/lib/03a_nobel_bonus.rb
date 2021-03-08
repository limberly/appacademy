# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT
      physics.yr, chemistry.yr
    FROM (
      SELECT
      yr, subject
      FROM
        nobels
      WHERE
        subject = 'Physics'
    ) AS physics
    LEFT JOIN (
      SELECT
        yr, subject
      FROM
        nobels
      WHERE
        subject = 'Chemistry'
    ) AS chemistry
    ON
      physics.yr = chemistry.yr
    WHERE
      chemistry.yr IS NULL
      

  SQL
end
