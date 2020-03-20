require_relative('../db/sql_runner')

class Transaction

attr_reader :id
attr_accessor :merchant_id, :tag_id

def initialize(options)
  @id = options['id'].to_i
  @merchant_id = options['merchant_id'].to_i
  @tag_id = options['tag_id'].to_i

end

def save()
  sql = "INSERT INTO transactions
  (
    merchant_id,
    tag_id
  )
  VALUES
  (
    $1, $2
  ) RETURNING *"
  values = [@merchant_id, @tag_id]
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
  transaction_data = SqlRunner.run(sql)
  return Transaction.new(transaction_data)
end

def self.delete_all
  sql = "DELETE FROM transactions"
  SqlRunner.run(sql)
end

def self.map_items(transation_data)
  result = transaction_data.map { |transaction| Transaction.new( transaction )}
  return result
end
end
