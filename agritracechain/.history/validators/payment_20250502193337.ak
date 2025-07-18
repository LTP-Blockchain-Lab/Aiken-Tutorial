use cardano/address.{Address}
use aiken/collection/list
use cardano/transaction.{Transaction, OutputReference}
use vodka_extra_signatories.{key_signed}
pub type PaymentDatum{
  product_id: ByteArray,
  seller_address: Address,
  price: Int,
  deadline: Int,
  is_paid: Bool,
}
pub type Redeemer{
  action: ByteArray,
  buyer_address: Address,
  payment_amount: Int,
}
validator payment{
    spend(datum: Option<PaymentDatum>, redeemer: Redeemer, _own_ref: OutputReference, self: Transaction) {
       expect Transaction{ inputs, outputs, extra_signatories, ..} = self
       when redeemer.action is{
        "Pay" -> {
            

        }
        _-> {
            False
        }
       }
    }
}