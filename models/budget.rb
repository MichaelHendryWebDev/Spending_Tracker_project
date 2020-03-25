require_relative('../db/sql_runner')

class Budget

  attr_reader :id
  attr_accessor :cash

  def initialize(options)
    @id = options['id'].to_i
    @cash = options['cash'].to_i
  end

def save()
  sql = "INSERT INTO budgets
  (
    cash
  )
  VALUES
  (
      $1
  ) RETURNING *"
  values = [@cash]
  budget = SqlRunner.run(sql, values).first
  @id = budget['id'].to_i
end

def update()
  sql = "UPDATE budgets
  SET type = $1
  WHERE id = $2"
  values = [@cash, @id]
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
  results = SqlRunner.run( sql )
  return results.map { |cash| Budget.new( cash ) }
end


def self.find(id)
  sql = "SELECT * FROM budgets WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  return Budget.new(results.first)
end
end
