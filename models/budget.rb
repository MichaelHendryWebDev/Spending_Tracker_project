require_relative('../db/sql_runner')

class Budget

  attr_reader :id
  attr_accessor :budget

  def initialize(options)
    @id = options['id']
    @budget = options['budget']
  end

def save()
  sql = "INSERT INTO budgets
  (
    budget
  )
  VALUES
  (
      $1
  ) RETURNING *"
  values = [@budget]
  budget = SqlRunner.run(sql, values).first
  @id = tag['id'].to_i
end

def update()
  sql = "UPDATE budgets
  SET type = $1
  WHERE id = $2"
  values = [@budget, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM budgets
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all
  sql = "DELETE FROM budgets"
  SqlRunner.run(sql)
end

def self.all()
sql = "SELECT * FROM budgets"
budget_data = SqlRunner.run(sql)
return Tag.map_items(budget_data)
end

def self.find(id)
  sql = "SELECT * FROM budgets WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  return Tag.new(results.first)
end
end
