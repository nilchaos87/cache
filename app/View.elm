module View exposing (view)

import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onClick)
import Css.Html exposing (style)
import Model exposing (Model)
import Data.Wallet exposing (Wallet)
import Update exposing (Msg(Input, Add, Remove))
import Styles


view =
    shell


shell : Model -> Html Msg
shell model =
    div [ style Styles.shell ] <| List.append (List.indexedMap wallet model.wallets) [ newWallet model.newAddress ]


wallet : Int -> Wallet -> Html Msg
wallet index wallet =
    div [ style <| Styles.wallet index ] [ button [ onClick <| Remove wallet.address ] [ text "-" ], text (wallet.address ++ " - " ++ (toString wallet.balance)) ]


newWallet : String -> Html Msg
newWallet newAddress =
    div [ style Styles.newWallet ] [ form newAddress ]


form : String -> Html Msg
form newAddress =
    div [ style Styles.form ] [ addressInput newAddress, addButton ]


addressInput : String -> Html Msg
addressInput newAddress =
    input [ onInput Input, value newAddress, style Styles.addressInput ] []


addButton : Html Msg
addButton =
    button [ onClick Add, style Styles.addButton ] [ text "+" ]
