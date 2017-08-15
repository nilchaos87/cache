module Main exposing (..)

import Html exposing (Html, program, div, input, button, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onClick)
import Http
import Css exposing (Style, displayFlex, flexFlow2, noWrap, column, alignItems, stretch, flex, position, absolute, top, right, bottom, left, px, int, backgroundColor, hex)
import Data.Balance
import Data.Wallet exposing (Wallet, wallet)
import Model exposing (Model)


main =
    program { init = (init { addresses = [] }), update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Model =
    { wallets : List Wallet
    , newAddress : String
    }


type alias Flags =
    { addresses : List String
    }


init : Flags -> ( Model, Cmd Msg )
init { addresses } =
    ( { wallets = List.map wallet addresses, newAddress = "" }, Cmd.batch <| List.map fetchBalance addresses )


type Msg
    = Input String
    | Add
    | UpdateBalance String (Result Http.Error Float)
    | Remove String


fetchBalance =
    Data.Balance.fetchBalance UpdateBalance


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newAddress ->
            ( { model | newAddress = newAddress }, Cmd.none )

        Add ->
            ( { model | wallets = List.append model.wallets [ wallet model.newAddress ], newAddress = "" }, fetchBalance model.newAddress )

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


style : List Style -> Html.Attribute msg
style =
    Css.asPairs >> Html.Attributes.style


viewStyles : List Style
viewStyles =
    [ displayFlex
    , flexFlow2 noWrap column
    , alignItems stretch
    , position absolute
    , top (px 0)
    , right (px 0)
    , bottom (px 0)
    , left (px 0)
    ]


view : Model -> Html Msg
view model =
    div [ style viewStyles ] <| List.append (List.map walletView model.wallets) [ newWalletView model.newAddress ]


walletViewStyle : List Style
walletViewStyle =
    [ flex (int 3)
    ]


walletView : Wallet -> Html Msg
walletView wallet =
    div [ style walletViewStyle ] [ button [ onClick <| Remove wallet.address ] [ text "-" ], text (wallet.address ++ " - " ++ (toString wallet.balance)) ]


newWalletViewStyle : List Style
newWalletViewStyle =
    [ flex (int 1)
    , backgroundColor <| hex "000"
    ]


newWalletView : String -> Html Msg
newWalletView newAddress =
    div [ style newWalletViewStyle ] [ input [ onInput Input, value newAddress ] [], button [ onClick Add ] [ text "Add" ] ]
