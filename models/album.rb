require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_accessor :name, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = 'INSERT INTO albums (
    name,
    genre,
    artist_id
    )
    VALUES (
      $1, $2, $3
      )
    RETURNING *;'
    values = [@name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def artist()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    result = SqlRunner.run(sql, [@artist_id])
    return Artist.new(result[0])
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map { |album| Album.new(album)  }
  end

end
