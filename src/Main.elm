module Main exposing (main)

import Html exposing (programWithFlags)
import Model exposing (Model)
import Data.Wallet exposing (wallet)
import Update exposing (Msg(UpdateBalance), fetchBalance, update)
import View exposing (view)


main =
    programWithFlags { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Flags =
    { addresses : List String
    }


init : Flags -> ( Model, Cmd Msg )
init { addresses } =
    let
        items =
            List.map (wallet UpdateBalance) addresses
    in
        ( { wallets = List.map Tuple.first items, newAddress = "" }, Cmd.batch <| List.map Tuple.second items )
