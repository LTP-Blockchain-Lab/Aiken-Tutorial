use cardano/address.{Address}
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction, OutputReference}
use vodka_extra_signatories.{key_signed}
use vodka_validity_range.{valid_after}



type ProductDatum {
  product_id: ByteArray,
  farmer_address: Address,
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
    product_owner: VerificationKeyHash
}

