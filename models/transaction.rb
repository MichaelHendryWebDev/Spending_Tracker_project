require_relative('../db/sql_runner')

class Transaction


attr_reader :id, :merchant_id, :tag_id, :amount

def initialize(options)
  @id = options['id'].to_i if options['id']
  @merchant_id = options['merchant_id'].to_i
  @tag_id = options['tag_id'].to_i
  @amount = options['amount'].to_i
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

def delete()
  sql = "DELETE FROM transactions WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql = "SELECT * FROM transactions"
  transaction = SqlRunner.run(sql)
  result = transaction.map {|transaction| Transaction.new(transaction)}
  return transaction
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
