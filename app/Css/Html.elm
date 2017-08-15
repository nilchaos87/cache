module Css.Html exposing (style)

import Css exposing (Style, asPairs)
import Html exposing (Attribute)
import Html.Attributes as Attributes


style : List Style -> Attribute msg
style =
    asPairs >> Attributes.style
