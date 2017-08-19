module View exposing (view)

import Html exposing (Html, div, fieldset, input, button, text, i)
import Html.Attributes exposing (class, value, placeholder)
import Html.Events exposing (onInput, onClick)
import Model exposing (Model)
import Data.Wallet exposing (Wallet)
import Update exposing (Msg(Input, Add, Remove))


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
    div [ class "wallet" ]
        [ address wallet.address
        , balance wallet.balance
        , actions wallet.address
        ]


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


actions address =
    div [ class "actions" ]
        [ button [] [ icon "refresh" ]
        , button [ onClick <| Remove address ] [ icon "trash" ]
        ]


newWallet : String -> Html Msg
newWallet newAddress =
    div [ class "new-wallet" ] [ fieldset [] [ addressInput newAddress, addButton ] ]


addressInput : String -> Html Msg
addressInput newAddress =
    input [ onInput Input, value newAddress, class "address", placeholder "New wallet address" ] []


addButton : Html Msg
addButton =
    button [ onClick Add, class "add" ] [ icon "plus" ]


icon : String -> Html msg
icon name =
    i [ class ("fa fa-" ++ name) ] []
