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

end
