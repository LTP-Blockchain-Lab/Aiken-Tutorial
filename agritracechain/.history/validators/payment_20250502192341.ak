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
pub type Redeemer{
  action: ByteArray,
  buyer_address: Address,
  payment_amount: Int,
}
validator payment{
    spend(datum: Option<PaymentDatum>, redeemer: Redeemer>, my_output_reference: OutputReference, self: Transaction) {
        expect Some(input) =
            self.inputs
                |> transaction.find_input(my_output_reference)
        expect datum.is_some() = true
        expect redeemer.is_some() = true
        expect input.output_reference.transaction_id == self.id
        expect input.output_reference.output_index == 0
        expect input.output.address == redeemer.buyer_address
        expect input.output.value.value >= redeemer.payment_amount
    }
}