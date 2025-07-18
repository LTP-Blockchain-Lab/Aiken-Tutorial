use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{
    OutputReference
}

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}

validator agritracechain{
    spend(datum_otp: Option<Datum>, _redeemer: OutputReference, )
}