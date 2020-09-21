module Icon exposing (..)

import Element exposing (Element)
import Html
import Svg exposing (Svg, svg)
import Svg.Attributes as Attributes


github : Element msg
github =
    svgFeatherIcon "github"
        [ Svg.path [ Attributes.d "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22" ] []
        ]
        |> Element.html
        |> Element.el []


book : Element msg
book =
    svgFeatherIcon "book"
        [ Svg.path [ Attributes.d "M4 19.5A2.5 2.5 0 0 1 6.5 17H20" ] []
        , Svg.path [ Attributes.d "M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" ] []
        ]
        |> Element.html
        |> Element.el []


svgFeatherIcon : String -> List (Svg msg) -> Html.Html msg
svgFeatherIcon className =
    svg
        [ Attributes.class <| "feather feather-" ++ className
        , Attributes.fill "none"
        , Attributes.height "16"
        , Attributes.stroke "currentColor"
        , Attributes.strokeLinecap "round"
        , Attributes.strokeLinejoin "round"
        , Attributes.strokeWidth "2"
        , Attributes.viewBox "0 0 24 24"
        , Attributes.width "16"
        ]
