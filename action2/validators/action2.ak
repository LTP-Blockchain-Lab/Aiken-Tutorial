use cardano/transaction.{OutputReference, Transaction}
use aiken/crypto.{VerificationKeyHash}
use vodka_extra_signatories.{key_signed}


pub type Datum {
    patient: VerificationKeyHash,
    doctor: VerificationKeyHash,
    cash_required: Int
}

validator action1
  
{
    spend(datum_otp: Option<Datum>, redeemer: Data, out_ref: OutputReference, tx: Transaction){
        expect Some(datum) = datum_otp
        
       or{
        key_signed(tx.extra_signatories, datum.doctor),
        
        key_signed(tx.extra_signatories, datum.patient)
       
        }
              
    }
    else(_) {
        fail
    }
}