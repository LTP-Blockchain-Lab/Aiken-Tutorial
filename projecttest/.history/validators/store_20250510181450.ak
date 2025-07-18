use aiken/crypto.{VerificationKeyHash}
use cardano/address
use cardano/assets.{without_lovelace}
use cardano/transaction.{
  InlineDatum, Output, OutputReference, Transaction, find_input,
}
use cardano/tx
use projecttest/types.{Remove, StoreRedeemer, Update}
use projecttest/utils
use types/cip68.{CIP68}
use validation/find.{output_by_addr_value}

validator store(
  farmer: VerificationKeyHash,
  author: VerificationKeyHash,
) {
  spend(
    datum: Option<CIP68>,
    redeemer: StoreRedeemer,
    output_reference: OutputReference,
    transaction: Transaction,
  ) {
    expect Some(datum_input) = datum
    let Transaction { inputs, outputs, extra_signatories, .. } = transaction
    let signed_by_author = tx.verify_signature(extra_signatories, author)
    let signed_by_farmer = tx.verify_signature(extra_signatories, farmer)

    when redeemer is {
      Update -> {
        let check_update = datum_input == datum
        and {
          check_update?,
          signed_by_author?,
          signed_by_farmer?,
        }
      }
      Remove -> {
        let check_remove = datum_input == datum
        and {
          check_remove?,
          signed_by_author?,
          signed_by_farmer?,
        }
      }
    }
         

  else(_) {
    fail
  }
}
