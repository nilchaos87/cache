module Data.Balance.Litecoin exposing (url, decoder)

import Data.Balance.ChainSO as ChainSO


url : String -> String
url =
    ChainSO.url "LTC"


decoder =
    ChainSO.decoder
