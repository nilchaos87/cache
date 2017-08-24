port module Update exposing (Msg(Input, Add, UpdateBalance, FetchBalance, Remove, ToggleErrorExpansion), save, update, fetchBalance)

import Data.Balance as Balance
import Data.Wallet exposing (Wallet, wallet)
import Model exposing (Model)
import Http


type Msg
    = Input String
    | Add
    | UpdateBalance String (Result Http.Error Float)
    | FetchBalance String
    | Remove String
    | ToggleErrorExpansion String


fetchBalance =
    Balance.fetch UpdateBalance


port save : List String -> Cmd msg


saveWallets : List Wallet -> Cmd msg
saveWallets wallets =
    List.map (\wallet -> wallet.address) wallets |> save


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newAddress ->
            ( { model | newAddress = newAddress }, Cmd.none )

        Add ->
            let
                newWallet =
                    model.newAddress |> wallet UpdateBalance

                wallets =
                    List.append model.wallets [ Tuple.first newWallet ]
            in
                ( { model | wallets = wallets, newAddress = "" }, Cmd.batch [ Tuple.second newWallet, saveWallets wallets ] )

        UpdateBalance address result ->
            case result of
                Ok balance ->
                    ( { model | wallets = List.map (updateBalance balance address) model.wallets }, Cmd.none )

                Err _ ->
                    ( { model | wallets = List.map (updateError "Error updating wallet balance" address) model.wallets }, Cmd.none )

        FetchBalance address ->
            ( { model | wallets = List.map (updateFetchingBalance True address) model.wallets }, fetchBalance address )

        Remove address ->
            let
                wallets =
                    List.filter (\wallet -> wallet.address /= address) model.wallets
            in
                ( { model | wallets = wallets }, saveWallets wallets )

        ToggleErrorExpansion address ->
            ( { model | wallets = List.map (toggleErrorExpansion address) model.wallets }, Cmd.none )


updateWallet : (Wallet -> Wallet) -> String -> Wallet -> Wallet
updateWallet update address wallet =
    if wallet.address == address then
        update wallet
    else
        wallet


updateBalance : Float -> String -> Wallet -> Wallet
updateBalance balance =
    updateWallet (\wallet -> { wallet | balance = Just balance, error = Nothing, fetchingBalance = False })


updateFetchingBalance : Bool -> String -> Wallet -> Wallet
updateFetchingBalance fetchingBalance =
    updateWallet (\wallet -> { wallet | fetchingBalance = fetchingBalance })


updateError : String -> String -> Wallet -> Wallet
updateError error =
    updateWallet (\wallet -> { wallet | balance = Nothing, error = Just error, fetchingBalance = False })


toggleErrorExpansion : String -> Wallet -> Wallet
toggleErrorExpansion =
    updateWallet (\wallet -> { wallet | expandError = not wallet.expandError })
