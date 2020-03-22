require_relative('../db/sql_runner')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize( options )
    @id = options['id']
    @name = options['name']

  end

  def save()
    sql = "INSERT INTO merchants
    (
      name
    )
    VALUES
    (
    $1
    ) RETURNING *"
    values = [@name]
    merchant = SqlRunner.run(sql, values).first
    @id = merchant['id'].to_i
  end

  def update
    sql = "UPDATE merchants
    SET type = $1
    WHERE id = $2"
    values = [@type, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find( id )
    sql = "SELECT * FROM merchants WHERE id = $1"
     values = [id]
    results = SqlRunner.run(sql, values)
    return Merchant.new(results.first)
  end



  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run( sql )
    return results.map { |merchant| Merchant.new( merchant ) }
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  

end
