module Data.Balance.Decred exposing (url, decoder)

import Json.Decode exposing (Decoder, field, float)


url : String -> String
url address =
    "https://mainnet.decred.org/api/addr/" ++ address ++ "/?noTxList=1"


decoder : Decoder Float
decoder =
    field "balance" float
