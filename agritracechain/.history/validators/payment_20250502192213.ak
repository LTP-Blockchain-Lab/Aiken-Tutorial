use cardano/address.{Address}
use aiken/collection/list
use cardano/transaction.{Transaction}

pub type PaymentDatum{
  product_id: ByteArray,
  seller_address: Address,
  price: Int,
  deadline: Int,
  is_paid: Bool,
}
