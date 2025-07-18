  use cardano/transaction.{Transaction, OutputReference, InlineDatum, Input, Output}
  use aiken/crypto.{VerificationKeyHash}
  use aiken/collection/list
  use vodka_extra_signatories.{key_signed}
  use cardano/address.{Address}

  pub type Datum {
    amount: Int,
    contributor: VerificationKeyHash,
    admin: VerificationKeyHash,
  }

  pub type Redeemer {
    actionChoice: ByteArray,

  }

  pub fn find_input(
    inputs: List<Input>,
    output_reference: OutputReference,
  ) -> Option<Input> {
    inputs
      |> list.find(fn(input) { input.output_reference == output_reference })
  }

  pub fn check_refund_completed(
    inputs: List<Input>,
    script_address: Address,
    user_address: Address,
  ) -> Bool {
    let script_inputs = list.filter(
      inputs,
      fn(input) { input.output.address == script_address }
    )

    let user_utxo_exists = list.any(
      script_inputs,
      fn(input) {
        when input.output.datum is {
          InlineDatum(data) -> {
            expect datum: Datum = data
            address.from_verification_key(datum.contributor) == user_address
          }
          _ -> False
        }
      }
    )
    
    user_utxo_exists 
  }

  validator contribute(admin: VerificationKeyHash){
    spend(datum_opt: Option<Datum>, redeemer: Redeemer, _out_ref: OutputReference, tx: Transaction) -> Bool {
      expect Some(datum) = datum_opt
      
      let Transaction {  extra_signatories, .. } = tx
      let signed_by_contributor = key_signed(extra_signatories, datum.contributor)
      let signed_by_admin = key_signed(extra_signatories, admin)
    // expect Some(input) = find_input(inputs, out_ref)
    // let admin_address = address.from_verification_key(admin)
    // let check_output_admin = find_output_address(outputs, admin_address)
    // let check_ouput_contributor = find_output_address(outputs, contributor_address)
      when redeemer.actionChoice is{
        "ExportMoney"->{
          let check_admin = datum.admin == admin
          or{
            and{
              signed_by_admin?,
              check_admin?,     
            },
              signed_by_contributor?
        }
        }
        _-> fail
      }
    

      }
    }
