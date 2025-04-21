use cardano/transaction.{Transaction, OutputReference, InlineDatum, Input, Output}
use aiken/crypto.{VerificationKeyHash}
use aiken/collection/list
use vodka_extra_signatories.{key_signed}
use cardano/address.{Address}

pub type Datum {
  contributor: VerificationKeyHash,
  receiver: VerificationKeyHash,
  amount: Int,
}

pub type Action {
  Contribute
  Refund
}

pub fn find_input(
  inputs: List<Input>,
  output_reference: OutputReference,
) -> Option<Input> {
  inputs
    |> list.find(fn(input) { input.output_reference == output_reference })
}

pub fn check_refund_completed(
  inputs: List<Input>,
  script_address: Address,
  user_address: Address,
) -> Bool {
  let script_inputs = list.filter(
    inputs,
    fn(input) { input.output.address == script_address }
  )

  let user_utxo_exists = list.any(
    script_inputs,
    fn(input) {
      when input.output.datum is {
        InlineDatum(data) -> {
          expect datum: Datum = data
          // So sánh payment credential thay vì toàn bộ địa chỉ
          address.from_verification_key(datum.contributor) == user_address
        }
        _ -> False
      }
    }
  )
  
  user_utxo_exists 
}

validator contribute{
  spend(datum_opt: Option<Datum>, redeemer: Action, out_ref: OutputReference, tx: Transaction) -> Bool {
    expect Some(datum) = datum_opt
    
    let Transaction { inputs, extra_signatories, .. } = tx
    let signed_by_contributor = key_signed(extra_signatories, datum.contributor)
    
    expect Some(input) = find_input(inputs, out_ref)
    let script_address = input.output.address
    let contributor_address = address.from_verification_key(datum.contributor)
    
    let check_utxo = check_refund_completed(
      inputs,
    
      script_address,
      contributor_address
    )

  
    signed_by_contributor&&
      
     when redeemer is {
      Contribute -> True
      Refund -> check_utxo
    }
  }
}