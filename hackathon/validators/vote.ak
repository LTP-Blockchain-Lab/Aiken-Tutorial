use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/address.{Address}
use cardano/transaction.{Output, OutputReference, Transaction}
use vodka_extra_signatories.{key_signed}



pub type Datum {
  voter: VerificationKeyHash,
  vote: ByteArray,
}

pub type Redeemer {
  actionChoice: ByteArray,
}

fn find_output_address(outputs: List<Output>, addrExport: Address) -> Bool {
  let check_ouput =
    outputs
      |> list.find(fn(output) { output.address == addrExport })
  if check_ouput == None {
    True
  } else {
    False
  }
}

validator vote(admin: VerificationKeyHash) {
  spend(
    datum_otp: Option<Datum>,
    redeemer: Redeemer,
    own_ref: OutputReference,
    self: Transaction,
  ) {
    expect Some(datum) = datum_otp
    let Transaction { outputs, extra_signatories, .. } = self
    let signByVoter = key_signed(extra_signatories, datum.voter)
    let signByAdmin = key_signed(extra_signatories, admin)
    let admin_address = address.from_verification_key(admin)
    let voter_address = address.from_verification_key(datum.voter)
    let check_output_admin = find_output_address(outputs, admin_address)
    let check_output_voter = find_output_address(outputs, voter_address)
    when redeemer.actionChoice is {
      "vote" -> {
        let check_say = or {
            datum.vote == "yes",
            datum.vote == "no",
          }
        and {
          signByVoter?,
          check_say?,
        }
      }
      "export" -> or {
          and {
            signByVoter?,
            check_output_voter?,
            check_output_admin?,
            !signByAdmin?,
          },
          and {
            signByAdmin?,
            !signByVoter?,
            check_output_admin?,
            check_output_voter?,
          },
        }
      _ -> fail
    }
  }

  else(_) {
    fail
  }
}
