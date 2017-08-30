module Main exposing (main)

import Html exposing (programWithFlags)
import Json.Decode exposing (Value)
import Model exposing (Model)
import Data.Wallet exposing (restore)
import Update exposing (Msg(UpdateBalance), update)
import View exposing (view)


main =
    programWithFlags { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Flags =
    { wallets : Value
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        wallets =
            restore UpdateBalance flags.wallets
    in
        ( { wallets = Tuple.first wallets, newAddress = "" }, Tuple.second wallets )
