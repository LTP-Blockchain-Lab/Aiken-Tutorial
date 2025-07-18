use cardano/address.{Address}
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction, OutputReference}
use vodka_extra_signatories.{key_signed}
use vodka_validi
pub type PaymentDatum{
  product_id: ByteArray,
  seller_address: Address,
  price: Int,
  deadline: Int,
  is_paid: Bool,
}
pub type Redeemer{
  action: VerificationKeyHash,
  buyer_address: Address,
  payment_amount: Int,
}
validator payment{
    spend(datum: Option<PaymentDatum>, redeemer: Redeemer, _own_ref: OutputReference, self: Transaction) {
       expect Transaction{ inputs, outputs, extra_signatories, ..} = self
       when redeemer.action is{
        "Pay" -> {

            and{
            key_signed(extra_signatories, redeemer.buyer_address)?,
            redeemer.payment_amount >= datum.price ?,
            datum.is_paid == 0 ?
            
            }
        }
        _-> {
            False
        }
       }
    }
}