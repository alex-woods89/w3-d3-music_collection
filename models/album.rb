require('pg')
require_relative('./artist')

class Album

attr_reader :artist_id, :id
attr_accessor :name, :genre

def initialize(options)
  @id = options['id'].to_i if options['id']
  @artist_id = options['artist_id'].to_i
  @name = options['name']
  @genre = options['genre']
end

def save
  sql = "INSERT INTO albums
        (artist_id, name, genre)
        VALUES
        ($1, $2, $3)
        RETURNING *"
 values = [@artist_id, @name, @genre]
 result = SqlRunner.run(sql, values)
 @id = result[0]['id'].to_i
end

def Album.all
  sql = 'SELECT * FROM albums'
  results = SqlRunner.run(sql)
  return results.map {|result| Album.new(result)}
end

def artist
  sql = 'SELECT * FROM artists WHERE id = $1'
  values = [@artist_id]
  results = SqlRunner.run(sql, values)
  array = results.map {|result| Artist.new(result)}
  return array[0]
end

def Album.delete_all
sql = 'DELETE FROM albums'
result = SqlRunner.run(sql)
end

def update
  sql = 'UPDATE albums SET
        (artist_id, name, genre)
        =
        ($1, $2, $3)
        WHERE id = $4
        RETURNING *'
   values = [@artist_id, @name, @genre, @id]
   result = SqlRunner.run(sql, values)
   updated_album = Album.new(result[0])
   return
end
end
