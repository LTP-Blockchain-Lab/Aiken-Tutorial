use cardano/transaction.{OutputReference, Transaction}
use vodka_extra_signatories.{key_signed}
use vodka_validity_range.{valid_after}
use aiken/crypto.{VerificationKeyHash}

pub type Datum {
  lock_until: Int,
  /// Owner's credentials
  owner: VerificationKeyHash,
  /// Beneficiary's credentials
  beneficiary: VerificationKeyHash,
}


validator smartContract{
  spend(
    datum_opt: Option<Datum>,
    _redeemer: Data,
    _own_ref: OutputReference,       
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

