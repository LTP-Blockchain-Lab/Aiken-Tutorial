use aiken/crypto.{VerificationKeyHash}

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}

validator agritracechain{
    spend(datum_otp: Option<Datum>, redeemer: )
}