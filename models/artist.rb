require_relative('../db/sql_runner.rb')


class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "
    INSERT INTO artists (
      name
      )
      VALUES (
        $1
      )
      RETURNING *;"
      result = SqlRunner.run(sql, [@name])
      @id = result[0]['id'].to_i()
  end

  def albums()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    result = SqlRunner.run(sql, [@id])
    return result.map { |album| Album.new(album)  }
  end

  def Artist.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map { |artist| Artist.new(artist) }
  end
end
