use aiken/crypto.{VerificationKeyHash}

pub type Datum{
    farmer: VerificationKeyHash,
    author: VerificationKeyHash
}