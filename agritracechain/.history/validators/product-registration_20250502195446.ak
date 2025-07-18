use cardano/address.{Address}
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction, OutputReference}
use vodka_extra_signatories.{key_signed, one_of_keys_signed}
use vodka_validity_range.{valid_after}



type ProductDatum {
  product_id: ByteArray,
  farmer: VerificationKeyHash,
  product_name: ByteArray,
  product_type: ByteArray,
  quantity: Int,
  unit: ByteArray,
  location: ByteArray,
  harvest_date: Int,
  certifications: List<ByteArray>,
  registration_date: Int,
}
pub type Redeemer{
    action: ByteArray,
    product_owner: VerificationKeyHash,
    verifier: List<VerificationKeyHash>,
}
validator product_registration{
    spend(datum_otp: Option<ProductDatum>, redeemer: Redeemer, _own_ref: OutputReference, self: Transaction) {
        expect Some(datum) = datum_otp
        expect Transaction{extra_signatories, validity_range, ..} = self
        when redeemer.action is{
            "Register" -> {
                and{
                    key_signed(extra_signatories, redeemer.product_owner)?,

                }
            }
            "Verify" -> {
                and{
                    one_of_keys_signed(extra_signatories, redeemer.verifier)?,
                    valid_after(validity_range, datum.registration_date)?,
                }
            }
            "Update" -> {
                key_signed(extra_signatories, datum.farmer)?,
            }
            "Update"
            _-> {
                False
            }
        }
    }
}

