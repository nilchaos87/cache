module Data.Balance.EthereumClassic exposing (fetch)

import Http exposing (Error, send, get)
import Json.Decode exposing (Decoder, at, float)


fetch : (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch msg address =
    send (msg address) <| get (url address) decoder


url : String -> String
url address =
    "https://api.gastracker.io/addr/" ++ address


decoder : Decoder Float
decoder =
    at [ "balance", "ether" ] float
