use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{
    
}

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}

validator agritracechain{
    spend(datum_otp: Option<Datum>, redeemer: _Out)
}