module Styles exposing (shell, wallet, newWallet, form, addressInput, addButton)

import Array exposing (Array)
import Css exposing (..)


standardFont : List Style -> List Style
standardFont styles =
    (fontFamily sansSerif) :: styles


type alias Palette =
    { lightest : Color
    , lighter : Color
    , medium : Color
    , darker : Color
    , darkest : Color
    }


palettes : Array Palette
palettes =
    [ { lightest = hex "ce763a"
      , lighter = hex "ffe2ce"
      , medium = hex "feb27f"
      , darker = hex "99470f"
      , darkest = hex "481d00"
      }
    , { lightest = hex "ce983a"
      , lighter = hex "ffedce"
      , medium = hex "fed07f"
      , darker = hex "99670f"
      , darkest = hex "482e00"
      }
    , { lightest = hex "2f5288"
      , lighter = hex "bbcbe3"
      , medium = hex "5c79a8"
      , darker = hex "123265"
      , darkest = hex "021430"
      }
    , { lightest = hex "258273"
      , lighter = hex "b5e0d9"
      , medium = hex "50a194"
      , darker = hex "0a6152"
      , darkest = hex "002e26"
      }
    ]
        |> Array.fromList


palette : Int -> Palette
palette dataIndex =
    let
        index =
            dataIndex % Array.length palettes
    in
        case (Array.get index palettes) of
            Just palette ->
                palette

            Nothing ->
                { lightest = hex "ccc"
                , lighter = hex "999"
                , medium = hex "777"
                , darker = hex "555"
                , darkest = hex "333"
                }


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
        |> standardFont


wallet : Int -> List Style
wallet index =
    let
        colors =
            palette index
    in
        [ flex (int 3)
        , backgroundColor <| colors.darkest
        , color <| colors.lightest
        , padding (px 10)
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
