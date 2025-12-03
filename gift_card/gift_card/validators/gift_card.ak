use aiken/collection/dict
use aiken/collection/list
use cardano/assets.{PolicyId, zero}
use cardano/transaction.{Input, OutputReference, Transaction} as tx
use mocktail.{complete, mint, mocktail_tx, tx_in}
use mocktail/virgin_address.{mock_pub_key_address}
use mocktail/virgin_key_hash.{mock_policy_id}
use mocktail/virgin_output_reference.{mock_tx_hash, mock_utxo_ref}

validator redeem(token_name: ByteArray, policy_id: ByteArray) {
  spend(_d: Option<Data>, _r: Data, _input: OutputReference, tx: Transaction) {
    let Transaction { mint, .. } = tx
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    amount == -1 && asset_name == token_name
  }

  else(_) {
    fail
  }
}

pub type Action {
  Mint
  Burn
}

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  mint(rdmr: Action, policy_id: PolicyId, tx: Transaction) {
    let Transaction { inputs, mint, .. } = tx
    expect Some(Pair(asset_name, amount)) =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
        |> list.find(fn(Pair(asset_name, _)) { asset_name == token_name })

    when rdmr is {
      Mint -> {
        expect Some(_input) =
          list.find(inputs, fn(input) { input.output_reference == utxo_ref })
        amount == 1 && asset_name == token_name
      }
      Burn -> amount == -1 && asset_name == token_name
    }
  }

  else(_) {
    fail
  }
}
