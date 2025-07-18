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
    spend(datum_otp: Option<Datum>, _redeemer: OutputReference, ctx: Transaction)
}