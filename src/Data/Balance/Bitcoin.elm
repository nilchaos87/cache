module Data.Balance.Bitcoin exposing (url, decoder)

import Data.Balance.ChainSO as ChainSO


url : String -> String
url =
    ChainSO.url "BTC"


decoder =
    ChainSO.decoder
