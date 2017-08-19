module Data.Balance exposing (fetchBalance)

import Http exposing (get, send)
import Json.Decode exposing (Decoder, float, string, andThen, at, succeed, fail)
import Data.Currency exposing (Currency(Bitcoin, Litecoin), currency)


fetchBalance : (String -> Result Http.Error Float -> msg) -> String -> Cmd msg
fetchBalance msg address =
    send (msg address) <| get (url address) decodeBalance


url address =
    "https://chain.so/api/v2/get_address_balance/" ++ (walletPath address)


walletPath : String -> String
walletPath address =
    case (currency address) of
        Bitcoin ->
            "BTC/" ++ address

        Litecoin ->
            "LTC/" ++ address


decodeBalance : Decoder Float
decodeBalance =
    at [ "data", "confirmed_balance" ] stringAsFloat


stringAsFloat : Decoder Float
stringAsFloat =
    let
        convert : String -> Decoder Float
        convert val =
            case (String.toFloat val) of
                Ok floatVal ->
                    succeed floatVal

                Err e ->
                    fail e
    in
        string |> andThen convert
