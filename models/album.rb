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

end
