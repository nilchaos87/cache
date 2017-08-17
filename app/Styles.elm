module Styles exposing (..)

import Array exposing (Array)
import Css exposing (..)


standardFont : Style
standardFont =
    fontFamily sansSerif


type alias Palette =
    { lightest : Color
    , lighter : Color
    , medium : Color
    , darker : Color
    , darkest : Color
    }


palettes : Array Palette
palettes =
    [ { lightest = hex "ce983a"
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
    , { lightest = hex "ce763a"
      , lighter = hex "ffe2ce"
      , medium = hex "feb27f"
      , darker = hex "99470f"
      , darkest = hex "481d00"
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
                { lightest = hex "fff"
                , lighter = hex "999"
                , medium = hex "666"
                , darker = hex "444"
                , darkest = hex "111"
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
    , standardFont
    ]


wallet : Int -> List Style
wallet index =
    let
        colors =
            palette index
    in
        [ flex (int 1)
        , backgroundColor <| colors.darkest
        , color <| colors.lightest
        , padding (px 10)
        ]


address : List Style
address =
    []


balance : List Style
balance =
    [ fontSize (Css.rem 2) ]


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
    [ height (px 30), boxSizing borderBox, minWidth (px 300), standardFont ]


addButton : List Style
addButton =
    [ height (px 30), width (px 30), boxSizing borderBox, standardFont ]
