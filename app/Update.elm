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
                wallets =
                    List.append model.wallets [ wallet model.newAddress True ]
            in
                ( { model | wallets = wallets, newAddress = "" }, Cmd.batch [ fetchBalance model.newAddress, saveWallets wallets ] )

        UpdateBalance address result ->
            case result of
                Ok balance ->
                    ( { model | wallets = List.map (\wallet -> updateBalance address balance wallet) model.wallets }, Cmd.none )

                Err _ ->
                    ( { model | wallets = List.map (\wallet -> updateError address "Error updating wallet balance" wallet) model.wallets }, Cmd.none )

        FetchBalance address ->
            ( { model | wallets = List.map (\wallet -> updateFetchingBalance address True wallet) model.wallets }, fetchBalance address )

        Remove address ->
            let
                wallets =
                    List.filter (\wallet -> wallet.address /= address) model.wallets
            in
                ( { model | wallets = wallets }, saveWallets wallets )

        ToggleErrorExpansion address ->
            ( { model | wallets = List.map (toggleErrorExpansion address) model.wallets }, Cmd.none )


updateBalance : String -> Float -> Wallet -> Wallet
updateBalance address balance wallet =
    if wallet.address == address then
        { wallet | balance = Just balance, error = Nothing, fetchingBalance = False }
    else
        wallet


updateFetchingBalance : String -> Bool -> Wallet -> Wallet
updateFetchingBalance address fetchingBalance wallet =
    if wallet.address == address then
        { wallet | fetchingBalance = fetchingBalance }
    else
        wallet


updateError : String -> String -> Wallet -> Wallet
updateError address error wallet =
    if wallet.address == address then
        { wallet | balance = Nothing, error = Just error, fetchingBalance = False }
    else
        wallet


toggleErrorExpansion : String -> Wallet -> Wallet
toggleErrorExpansion address wallet =
    if wallet.address == address then
        { wallet | expandError = not wallet.expandError }
    else
        wallet
