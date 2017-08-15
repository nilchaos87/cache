module Main exposing (..)

import Html exposing (program)
import Model exposing (Model)
import Data.Wallet exposing (wallet)
import Update exposing (Msg, fetchBalance, update)
import View exposing (view)


main =
    program { init = (init { addresses = [] }), update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Flags =
    { addresses : List String
    }


init : Flags -> ( Model, Cmd Msg )
init { addresses } =
    ( { wallets = List.map wallet addresses, newAddress = "" }, Cmd.batch <| List.map fetchBalance addresses )
