module Main exposing (..)

import Html exposing (Html, program, div, input, button, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onClick)
import Css exposing (Style, displayFlex, flexFlow2, noWrap, column, alignItems, stretch, flex, position, absolute, top, right, bottom, left, px, int, backgroundColor, hex)
import Data.Wallet exposing (Wallet, wallet)
import Model exposing (Model)
import Update exposing (Msg(Input, Add, Remove), fetchBalance, update)


main =
    program { init = (init { addresses = [] }), update = update, view = view, subscriptions = (\_ -> Sub.none) }


type alias Flags =
    { addresses : List String
    }


init : Flags -> ( Model, Cmd Msg )
init { addresses } =
    ( { wallets = List.map wallet addresses, newAddress = "" }, Cmd.batch <| List.map fetchBalance addresses )


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
