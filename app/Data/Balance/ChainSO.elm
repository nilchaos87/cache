module Data.Balance.ChainSO exposing (fetch)

import Http exposing (Error, send, get)
import Json.Decode exposing (Decoder, at, string, fail, succeed, andThen)


fetch : (String -> String) -> (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch url msg address =
    send (msg address) <| get (url address) decoder


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
