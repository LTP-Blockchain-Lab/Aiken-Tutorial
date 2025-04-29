use cardano/transaction.{OutputReference, Transaction}
use vodka_extra_signatories.{key_signed}
use vodka_validity_range.{valid_after}
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{PolicyId, AssetName}
pub type Asset {
  policy_id: PolicyId,
  //id nft
  token_name: AssetName,
  // name nft
  amt: Int,
}
pub type Datum {
  lock_until: Int,
  /// Owner's credentials
  owner: VerificationKeyHash,
  /// Beneficiary's credentials
  beneficiary: VerificationKeyHash,
  //time lock
  message: ByteArray,
  nft: Asset,
  locked_ada: Int,
}

// fn must_start_after(
//   range: ValidityRange,
//   lock_expiration_time: Int,
// ) -> Bool {
//     when range.lower_bound.bound_type is{
//         Finite(tx_earliest_time) -> 
//         lock_expiration_time > tx_earliest_time  // Kiểm tra xem thời gian hiện tại có lớn hơn tx_earliest_time không.
//         _ -> False  // Nếu không có lower_bound cụ thể, trả về False.
//   }
   
// }

validator vesting {
  spend(
    datum_opt: Option<Datum>,
    redeemer: Data,
    own_ref: OutputReference,       
    tx: Transaction,
  ) {
    expect Some(datum) = datum_opt 
     or {
      key_signed(tx.extra_signatories, datum.owner) ,
      and {
        key_signed(tx.extra_signatories, datum.beneficiary),
        valid_after(tx.validity_range, datum.lock_until)  
    },}
   
    } 
      else(_){ 
      fail
  } 
 
}

