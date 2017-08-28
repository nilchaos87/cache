module Cache.Icon exposing (add, error, refresh, remove, appearance)

import Html exposing (Html, div, i)
import Html.Attributes exposing (classList, class)


icon : List String -> Html msg
icon names =
    let
        classes =
            "fa" :: (List.map (\name -> "fa-" ++ name) names)
    in
        div [ class "icon" ] [ i [ classList <| List.map (\c -> ( c, True )) classes ] [] ]


add : Html msg
add =
    icon [ "plus" ]


error : Html msg
error =
    icon [ "warning" ]


refresh : Bool -> Html msg
refresh spin =
    icon <|
        if spin then
            [ "refresh", "spin" ]
        else
            [ "refresh" ]


remove : Html msg
remove =
    icon [ "trash" ]


appearance : Html msg
appearance =
    icon [ "paint-brush" ]
