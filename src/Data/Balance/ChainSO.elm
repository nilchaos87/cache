module Data.Balance.ChainSO exposing (url, decoder)

import Json.Decode exposing (Decoder, at, string, fail, succeed, andThen)


url : String -> String -> String
url currency address =
    String.join "/" [ "https://chain.so/api/v2/get_address_balance", currency, address ]


decoder : Decoder Float
decoder =
    at [ "data", "confirmed_balance" ] floatString


floatString : Decoder Float
floatString =
    let
        float val =
            case (String.toFloat val) of
                Ok floatVal ->
                    succeed floatVal

                Err e ->
                    fail e
    in
        string |> andThen float
