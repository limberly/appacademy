# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          max(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      countries.continent, name, countries.area
    FROM
      countries, (
      SELECT
        max(area) as max, continent
      FROM
        countries
      GROUP BY
        continent
    ) as maximum
    WHERE
      countries.continent = maximum.continent AND countries.area = maximum.max
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT DISTINCT
      countries.name, countries.continent
    FROM
      countries
    WHERE countries.population > ALL (
      SELECT
        population * 3 as pop3
      FROM
        countries as large
      WHERE
        countries.continent = large.continent
      AND
        countries.name != large.name  
    )

  SQL
end
