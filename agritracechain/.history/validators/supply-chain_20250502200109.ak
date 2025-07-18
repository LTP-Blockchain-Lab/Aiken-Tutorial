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
  current_handler: Address,
  history: List<HistoryEntry>,
  last_updated: Int,
  
}
pub type Red

