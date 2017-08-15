module Styles exposing (shell, wallet, newWallet, form, addressInput, addButton)

import Css exposing (..)


standardFont : List Style -> List Style
standardFont styles =
    (fontFamily sansSerif) :: styles


shell : List Style
shell =
    [ displayFlex
    , flexFlow2 noWrap column
    , alignItems stretch
    , position absolute
    , top (px 0)
    , right (px 0)
    , bottom (px 0)
    , left (px 0)
    ]


wallet : List Style
wallet =
    [ flex (int 3)
    ]


newWallet : List Style
newWallet =
    [ flex (int 1)
    , backgroundColor <| hex "000"
    , flexFlow2 noWrap row
    , alignItems center
    , displayFlex
    ]


form : List Style
form =
    [ flex (int 1), textAlign center ]


addressInput : List Style
addressInput =
    [ height (px 30), boxSizing borderBox, minWidth (px 300) ] |> standardFont


addButton : List Style
addButton =
    [ height (px 30), width (px 30), boxSizing borderBox ] |> standardFont
