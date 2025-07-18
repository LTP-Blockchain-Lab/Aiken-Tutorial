use cardano/address.{Credential}
use cardano/assets.{PolicyId}
//use cardano/certificate.{Certificate}
//use cardano/governance.{ProposalProcedure, Voter}
use cardano/transaction.{Transaction, OutputReference}

pub type MyDatum{
    data: Data
}

validator my_script {
  mint(redeemer: Data, policy_id: PolicyId, self: Transaction) {
    True
  }
 
  spend(datum: Option<MyDatum>, _redeemer: Data, utxo: OutputReference, self: Transaction) {
    True
  }
 
  else(_){
    fail
  }  
}