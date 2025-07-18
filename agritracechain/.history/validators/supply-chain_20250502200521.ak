use cardano/address.{Address}
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction, OutputReference}
use vodka_extra_signatories.{key_signed, one_of_keys_signed}
use vodka_validity_range.{valid_after}


pub type Datum{
  product_id: ByteArray,
  current_status: ByteArray,
  current_location: ByteArray,
  current_handler: VerificationKeyHash,
  history: ByteArray,
  last_updated: Int,
  
}
pub type Redeemer{
  action: ByteArray,
  status: ByteArray,
  new_location: ByteArray,
  new_handler: VerificationKeyHash,
}

validator supply_chain{
    spend(datum_otp: Option<Datum>, redeemer: Redeemer, _own_ref: OutputReference, self: Transaction) {
        expect Some(datum) = datum_otp
        expect Transaction{extra_signatories, validity_range, ..} = self
        when redeemer.action is{
            "UpdateStatus" -> {
                and{
                    key_signed(extra_signatories, datum.current_handler)?,
                    valid_after(validity_range, datum.last_updated)?,
                    (datum.current_status == redeemer.status) ?,
                }
            }
            "UpdateLocation" -> {
                and{
                    key_signed(extra_signatories, datum.current_handler)?,
                    valid_after(validity_range, datum.last_updated)?,
                    (datum.current_location == redeemer.new_location) ?,
                }
            }
            "TransferOwnership" -> {
                and{
                    one_of_keys_signed(extra_signatories, datum.history)?,
                    valid_after(validity_range, datum.last_updated)?,
                }
            }

            "Complete" -> {
                key_signed(extra_signatories, datum.current_handler)?
            }
            _-> {
                False
            }
        }
    }
}

