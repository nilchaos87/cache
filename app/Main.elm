module Main exposing (main)

import Html exposing (programWithFlags)
import Model exposing (Model)
import Data.Wallet exposing (Wallet)
import Update exposing (Msg, fetchBalance, update)
import View exposing (view)


main =
    programWithFlags { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Flags =
    { addresses : List String
    }


wallet : String -> Wallet
wallet address =
    Data.Wallet.wallet address True


init : Flags -> ( Model, Cmd Msg )
init { addresses } =
    ( { wallets = List.map wallet addresses, newAddress = "" }, Cmd.batch <| List.map fetchBalance addresses )
