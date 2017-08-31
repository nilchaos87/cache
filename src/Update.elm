module Update exposing (Msg(Input, Add, UpdateBalance, FetchBalance, Remove, ToggleErrorExpansion, RotateClass, MoveUp, MoveDown), update)

import Data.Balance as Balance
import Data.Wallet exposing (Wallet, new, save)
import Model exposing (Model)
import Http


type Msg
    = Input String
    | Add
    | UpdateBalance String (Result Http.Error Float)
    | FetchBalance String
    | Remove String
    | ToggleErrorExpansion String
    | RotateClass String
    | MoveUp String
    | MoveDown String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newAddress ->
            ( { model | newAddress = newAddress }, Cmd.none )

        Add ->
            let
                newWallet =
                    new UpdateBalance model.newAddress

                wallets =
                    List.append model.wallets [ Tuple.first newWallet ]
            in
                ( { model | wallets = wallets, newAddress = "" }, Cmd.batch [ Tuple.second newWallet, save wallets ] )

        UpdateBalance address result ->
            case result of
                Ok balance ->
                    ( { model | wallets = List.map (updateBalance balance address) model.wallets }, Cmd.none )

                Err _ ->
                    ( { model | wallets = List.map (updateError "Error updating wallet balance" address) model.wallets }, Cmd.none )

        FetchBalance address ->
            ( { model | wallets = List.map (updateFetchingBalance True address) model.wallets }, Balance.fetch UpdateBalance address )

        Remove address ->
            let
                wallets =
                    List.filter (\wallet -> wallet.address /= address) model.wallets
            in
                ( { model | wallets = wallets }, save wallets )

        ToggleErrorExpansion address ->
            ( { model | wallets = List.map (toggleErrorExpansion address) model.wallets }, Cmd.none )

        RotateClass address ->
            let
                wallets =
                    List.map (rotateClass address) model.wallets
            in
                ( { model | wallets = wallets }, save wallets )

        MoveUp address ->
            let
                wallets =
                    List.sortBy (.order >> negate) <|
                        List.map (moveUp address) model.wallets
            in
                ( { model | wallets = wallets }, save wallets )

        MoveDown address ->
            let
                wallets =
                    List.sortBy (.order >> negate) <|
                        List.map (moveDown address) model.wallets
            in
                ( { model | wallets = wallets }, save wallets )


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


rotateClass : String -> Wallet -> Wallet
rotateClass =
    updateWallet (\wallet -> { wallet | class = nextClass wallet.class })


nextClass : Int -> Int
nextClass current =
    case current of
        4 ->
            1

        _ ->
            current + 1


moveUp : String -> Wallet -> Wallet
moveUp =
    updateWallet (\wallet -> { wallet | order = wallet.order + 1 })


moveDown : String -> Wallet -> Wallet
moveDown =
    updateWallet (\wallet -> { wallet | order = wallet.order - 1 })
