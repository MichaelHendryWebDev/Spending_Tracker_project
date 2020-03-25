require( 'pry-byebug')
require_relative( '../models/merchant')
require_relative( '../models/tag')
require_relative( '../models/transaction')

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

merchant1 = Merchant.new(
  {'name' => 'OzCorp', 'state' => true})
merchant1.save()

tag1 = Tag.new(
  {'type' => 'scientific'})
tag1.save()

transaction1 = Transaction.new(
  {'merchant_id' => merchant1.id,
  'tag_id' => tag1.id, 'amount' => 100, 'total' => 0})
transaction1.save()

binding.pry
nil
