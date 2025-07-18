use aiken/crypto.{VerificationKeyHash}
use aiken.

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}

validator agritracechain{
    spend(datum_otp: Option<Datum>, redeemer: _Out)
}