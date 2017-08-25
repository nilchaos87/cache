module View exposing (view)

import Html exposing (Html, div, fieldset, input, button, text, i, span)
import Html.Attributes exposing (class, value, placeholder)
import Html.Events exposing (onInput, onClick)
import Cache.Icon as Icon
import Model exposing (Model)
import Data.Wallet exposing (Wallet)
import Update exposing (Msg(Input, Add, FetchBalance, Remove, ToggleErrorExpansion))


view =
    shell


shell : Model -> Html Msg
shell model =
    div [ class "shell" ] <| [ wallets model.wallets, newWallet model.newAddress ]


wallets : List Wallet -> Html Msg
wallets list =
    List.map wallet list |> div [ class "wallets" ]


wallet : Wallet -> Html Msg
wallet wallet =
    let
        baseContent =
            [ address wallet.address
            , balance wallet.balance
            , actions wallet
            ]

        content =
            case wallet.error of
                Just message ->
                    List.append baseContent [ error message wallet.expandError wallet.address ]

                Nothing ->
                    baseContent
    in
        div [ class "wallet" ] content


address : String -> Html msg
address content =
    div [ class "address" ] [ text content ]


balance : Maybe Float -> Html msg
balance bal =
    let
        content =
            case bal of
                Just b ->
                    (toString b)

                Nothing ->
                    "--"
    in
        div [ class "balance" ] [ text content ]


error : String -> Bool -> String -> Html Msg
error message expand address =
    let
        buttonClass =
            if expand then
                "expanded"
            else
                "collapsed"

        buttonContent =
            [ Icon.error, span [ class "message" ] [ text message ] ]
    in
        div [ class "error" ] [ button [ class buttonClass, onClick <| ToggleErrorExpansion address ] buttonContent ]


actions : Wallet -> Html Msg
actions { address, fetchingBalance } =
    div [ class "actions" ]
        [ button [ onClick (FetchBalance address) ] [ Icon.refresh fetchingBalance ]
        , button [ onClick <| Remove address ] [ Icon.remove ]
        ]


newWallet : String -> Html Msg
newWallet newAddress =
    div [ class "new-wallet" ] [ fieldset [] [ addressInput newAddress, addButton ] ]


addressInput : String -> Html Msg
addressInput newAddress =
    input [ onInput Input, value newAddress, class "address", placeholder "New wallet address" ] []


addButton : Html Msg
addButton =
    button [ onClick Add, class "add" ] [ Icon.add ]
