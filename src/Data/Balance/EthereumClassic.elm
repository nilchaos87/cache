module Data.Balance.EthereumClassic exposing (url, decoder)

import Json.Decode exposing (Decoder, at, float)


url : String -> String
url address =
    "https://api.gastracker.io/addr/" ++ address


decoder : Decoder Float
decoder =
    at [ "balance", "ether" ] float
