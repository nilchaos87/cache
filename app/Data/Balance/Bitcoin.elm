module Data.Balance.Bitcoin exposing (fetch)

import Http exposing (Error)
import Data.Balance.ChainSO as ChainSO


fetch : (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch =
    ChainSO.fetch url


url : String -> String
url address =
    "https://chain.so/api/v2/get_address_balance/BTC/" ++ address
