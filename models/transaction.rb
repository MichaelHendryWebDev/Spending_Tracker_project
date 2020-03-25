require_relative('../db/sql_runner')

class Transaction


attr_reader :id
attr_accessor :merchant_id, :tag_id, :amount, :total

def initialize(options)
  @id = options['id'].to_i
  @merchant_id = options['merchant_id'].to_i
  @tag_id = options['tag_id'].to_i
  @amount = options['amount'].to_i
end

def self.add_total(transactions)
  total = 0
  for transaction in transactions
    total += transaction.amount
  end
  return total
end



def save()
  sql = "INSERT INTO transactions
  (
    merchant_id,
    tag_id,
    amount
  )
  VALUES
  (
    $1, $2, $3
  ) RETURNING id"
  values = [@merchant_id, @tag_id, @amount]
  transaction = SqlRunner.run(sql, values).first
  @id = transaction['id'].to_i
end

def update()
    sql = "UPDATE transactions
    SET amount = $1
    WHERE id = $2"
    values = [@amount, @id]
    SqlRunner.run( sql, values )
  end

def delete()
  sql = "DELETE FROM transactions WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def merchants()
  sql = "SELECT * FROM merchants WHERE id = $1"
  values = [@merchant_id]
  results = SqlRunner.run(sql, values)
  return Merchant.new( results.first)
end

def tags()
  sql = "SELECT * FROM tags WHERE id = $1"
  values = [@tag_id]
  results = SqlRunner.run(sql, values)
  return results.map {|tag| Tag.new(tag)}
end


def self.find( id )
  sql = "SELECT * FROM transactions WHERE id = $1"
   values = [id]
  results = SqlRunner.run(sql, values)
  return Transaction.new(results.first)
end

def self.all()
  sql = "SELECT * FROM transactions"
  results = SqlRunner.run(sql)
  return results.map { |transaction| Transaction.new(transaction)}
end

def self.delete_all
  sql = "DELETE FROM transactions"
  SqlRunner.run(sql)
end


end
