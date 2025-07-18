use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{
    OutputReference,
    Transaction
}
use vodka_extra_signatories.{key_signed, one_of_keys_signed}

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}

validator agritracrchain{
    spend(datum_otp: Option<Datum>, redeemer: Data, out_ref: OutputReference, tx: Transaction){
        expect Some(datum) = datum_otp

       or{
        key_signed(tx.extra_signatories, datum.patient) ,
        one_of_keys_signed(tx.extra_signatories, datum.doctor)
       } 
    }
    else(_) {
        fail
    }

}