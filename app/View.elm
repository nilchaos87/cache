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
    div [ style Styles.shell ] <| List.append (List.map wallet model.wallets) [ newWallet model.newAddress ]


wallet : Wallet -> Html Msg
wallet wallet =
    div [ style Styles.wallet ] [ button [ onClick <| Remove wallet.address ] [ text "-" ], text (wallet.address ++ " - " ++ (toString wallet.balance)) ]


newWallet : String -> Html Msg
newWallet newAddress =
    div [ style Styles.newWallet ] [ input [ onInput Input, value newAddress ] [], button [ onClick Add ] [ text "Add" ] ]
