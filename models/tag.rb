require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :type

  def initialize(options)
    @id = options['id']
    @type = options['type']
  end

  def save()
  sql = "INSERT INTO tags
  (
    type
  )
  VALUES
  (
    $1
  ) RETURNING *"
  values = [@type]
  tag = SqlRunner.run(sql, values).first
  @id = tag['id'].to_i
end

def update()
  sql = "UPDATE tags SET
  (
    type
  ) = (
    $1
  ) WHERE id = $2"
  values = [@type]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM tags
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def merchants()
  sql = "SELECT merchants.* FROM merchants merchants INNER JOIN transactions transactions ON transactions.merchant_id = merchant_id WHERE transactions.tag_id = $1"
  values = [@id]
  tag_data = SqlRunner.run(sql, values)
  return Merchant.map_items(tag_data)
end

def self.delete_all
  sql = "DELETE FROM tags"
  SqlRunner.run(sql)
end

def self.all()
sql = "SELECT * FROM tags"
tag_data = SqlRunner.run(sql)
return Tag.map_items(tag_data)
end

def self.find(id)
  sql = "SELECT * FROM tags WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  return Tag.new(results.first)
end

def self.map_items(tag_data)
  result = tag_data.map { |tag| Tag.new(tag)}
  return result
end

end
