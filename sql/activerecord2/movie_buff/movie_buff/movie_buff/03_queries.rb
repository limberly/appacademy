def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  len = those_actors.length
  Movie
  .joins(:actors)
  .where(actors: {name: those_actors})
  .group(:id)
  .order("count(actors.id)")
  .having("count(actors.id) >= ?", len)
  .select(:title, :id)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select("AVG(score), (yr / 10) * 10 as decade").group(:decade).order("AVG(score) DESC").limit(1)[0].decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  subq = Movie.joins(:actors).where(actors: {name: name}).pluck(:id)

  Movie.joins(:actors).where("actors.name != ? AND movies.id IN (?)", name, subq).distinct.pluck("actors.name")


end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.left_joins(:movies).where("movies.id is null").count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  matcher = "%#{whazzername.split("").join("%")}%"
  Movie.joins(:actors).where("actors.name iLIKE ?", matcher)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.select("actors.id, name, max(movies.yr) - min(movies.yr) as career").joins(:movies).group(:id).order("career DESC, actors.name").limit(3)
end
