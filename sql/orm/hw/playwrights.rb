require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
    include Singleton
    def initialize
        super('plays.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Playwright

    attr_accessor :name, :birth_year

    def self.all
        data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
        data.map {|writer| Playwright.new(writer)}
    end

    def initialize(options)
        @id = options['id']
        @name = options['name']
        @birth_year = options['birth_year']
    end

    def create
        raise "#{self} already in database" if @id
        PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
            INSERT INTO
                playwrights (name, birth_year)
            VALUES
                (?, ?)
        SQL
        @id = PlayDBConnection.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, @id)
            UPDATE
                playwrights
            SET
                name = ?, birth_year = ?
            WHERE
                id = ?
        SQL
    end

    def get_plays(name)
        PlayDBConnection.instance.execute(<<-SQL, name)
            SELECT
                title, year
            FROM
                playwrights
            JOIN
                plays ON plays.playwright_id = playwrights.id
            WHERE
                name = ?
        SQL
    end
end
