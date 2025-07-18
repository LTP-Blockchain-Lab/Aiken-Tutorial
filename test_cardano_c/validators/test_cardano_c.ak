use cardano/transaction.{OutputReference
}

pub type Datum{
    number: Int,
}
pub type Redeemer{
    value: ByteArray,
}
validator test_cardano_c{
    spend(datum_otp: Option<Datum>, redeemer: Redeemer, _ctx: ByteArray, _out_ref: OutputReference ){
        expect Some(datum) = datum_otp

        redeemer.value == "Long is the father Hung"
    }  

}

