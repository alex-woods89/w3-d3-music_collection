require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists
    (name)
    VALUES
    ($1)
    RETURNING *"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def Artist.all
    sql = 'SELECT * FROM artists'
    results = SqlRunner.run(sql)
    return results.map {|result| Artist.new(result)}
  end

  def albums
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|result| Album.new(result)}
  end

  def Artist.delete_all
  sql = 'DELETE FROM artists'
  result = SqlRunner.run(sql)
  end

end
