port module Update exposing (Msg(Input, Add, UpdateBalance, Remove), save, update, fetchBalance)

import Data.Balance as Balance
import Data.Wallet exposing (Wallet, wallet)
import Model exposing (Model)
import Http


type Msg
    = Input String
    | Add
    | UpdateBalance String (Result Http.Error Float)
    | Remove String


fetchBalance =
    Balance.fetchBalance UpdateBalance


port save : List String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newAddress ->
            ( { model | newAddress = newAddress }, Cmd.none )

        Add ->
            let
                wallets =
                    List.append model.wallets [ wallet model.newAddress ]
            in
                ( { model | wallets = wallets, newAddress = "" }, Cmd.batch [ fetchBalance model.newAddress, List.map (\wallet -> wallet.address) wallets |> save ] )

        UpdateBalance address result ->
            case result of
                Ok balance ->
                    ( { model | wallets = List.map (\wallet -> updateBalance address balance wallet) model.wallets }, Cmd.none )

                Err _ ->
                    ( { model | wallets = List.map (\wallet -> updateError address "Error updating wallet balance" wallet) model.wallets }, Cmd.none )

        Remove address ->
            ( { model | wallets = List.filter (\wallet -> wallet.address /= address) model.wallets }, Cmd.none )


updateBalance : String -> Float -> Wallet -> Wallet
updateBalance address balance wallet =
    if wallet.address == address then
        { wallet | balance = Just balance, error = Nothing }
    else
        wallet


updateError : String -> String -> Wallet -> Wallet
updateError address error wallet =
    if wallet.address == address then
        { wallet | balance = Nothing, error = Just error }
    else
        wallet
