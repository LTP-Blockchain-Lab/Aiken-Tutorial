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

    
          }
          Remove -> {
            let author_address = address.from_verification_key(author_input)
            utils.check_output_remove(
              outputs,
              platform_address,
              platform_fee,
              author_address,
            )
          }
        }
    }
  }

  else(_) {
    fail
  }
}
