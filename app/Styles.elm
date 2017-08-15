module Styles exposing (shell, wallet, newWallet)

import Css exposing (..)


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
    ]
