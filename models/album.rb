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

  def update()
    sql = "UPDATE albums
    SET (
      name,
      genre
    )
    =
    (
      $1, $2
    )
    WHERE id = $3;"
    SqlRunner.run(sql, [@name, @genre, @id])
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end


  def Album.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map { |album| Album.new(album)  }
  end

  def Album.find(album_id)
    sql = "SELECT * FROM albums
    WHERE id = $1"
    result = SqlRunner.run(sql, [album_id])
    return result.map { |album| Album.new(album) }
  end

end
