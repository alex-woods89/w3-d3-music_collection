require('pry-byebug')
require_relative('./artist')
require_relative('./album')

artist1 = Artist.new({'name' => 'Led Zeppelin'})
artist1.save

album1 = Album.new({ 'artist_id' => artist1.id,
                      'name' => 'Houses of the Holy',
                      'genre' => 'rock'})
album1.save

binding.pry
nil
