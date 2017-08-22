module Data.Balance.Decred exposing (fetch)

import Http exposing (Error, send, get)
import Json.Decode exposing (Decoder, field, float)


fetch : (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch msg address =
    send (msg address) <| get (url address) decoder


url : String -> String
url address =
    "https://mainnet.decred.org/api/addr/" ++ address ++ "/?noTxList=1"


decoder : Decoder Float
decoder =
    field "balance" float
