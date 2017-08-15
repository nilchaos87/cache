module Data.Balance exposing (fetchBalance)

import Http exposing (get, send)
import Json.Decode exposing (Decoder, float, andThen, succeed, fail)


fetchBalance : (String -> Result Http.Error Float -> msg) -> String -> Cmd msg
fetchBalance msg address =
    send (msg address) <| get ("https://blockchain.info/q/addressbalance/" ++ address) decodeBalance


decodeBalance : Decoder Float
decodeBalance =
    let
        convert : Float -> Decoder Float
        convert val =
            succeed <| val / 100000000
    in
        float |> andThen convert
