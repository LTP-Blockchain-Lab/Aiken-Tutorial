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

validator agritracechain{
    spend(datum_otp: Option<Datum>, redeemer: Data, _out_ref: OutputReference, tx: Transaction){
        expect Some(datum) = datum_otp

       or{
        key_signed(tx.extra_signatories, datum.farmer) ,(tx.extra_signatories, datum.author)
       } 
    }
    else(_) {
        fail
    }

}