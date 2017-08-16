module Styles exposing (shell, wallet, newWallet, form, addressInput, addButton)

import Array exposing (Array)
import Css exposing (..)


standardFont : List Style -> List Style
standardFont styles =
    (fontFamily sansSerif) :: styles


type alias Palette =
    { dark : Color
    , medium : Color
    , light : Color
    }


defaultPalette : Palette
defaultPalette =
    { dark = hex "333", medium = hex "888", light = hex "ddd" }


palettes : Array Palette
palettes =
    [ { dark = hex "500", medium = hex "aa3939", light = hex "faa" }
    , { dark = hex "552600", medium = hex "aa6c39", light = hex "ffd1aa" }
    , { dark = hex "033", medium = hex "266", light = hex "699" }
    , { dark = hex "040", medium = hex "2d882d", light = hex "8c8" }
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
                defaultPalette


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
        , backgroundColor colors.dark
        , color colors.light
        , borderTop3 (px 1) solid colors.medium
        , borderBottom3 (px 1) solid <| hex "000"
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
