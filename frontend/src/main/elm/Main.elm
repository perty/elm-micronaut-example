module Main exposing (main)

import Api exposing (Greeting)
import Browser
import Browser.Events as Events
import Browser.Navigation as Navigation
import Element exposing (Element, el, text)
import Html
import Http
import Icon
import Theme exposing (materialStyle)
import Widget exposing (Select, TextButton, column, row, tab, textButton)
import Widget.Layout as Layout exposing (Layout, Part(..))


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { greeting : Greeting
    , selectedTab : Maybe Int
    , section : Section
    , layout : Layout Msg
    , sections : Select Msg
    , search : String
    , window : { width : Int, height : Int }
    }


type Section
    = Home
    | Casinos
    | Help


sectionFromInt : Int -> Section
sectionFromInt n =
    case n of
        0 ->
            Home

        1 ->
            Casinos

        2 ->
            Help

        _ ->
            Home


init : () -> ( Model, Cmd Msg )
init _ =
    ( { greeting = { id = 0, content = "" }
      , selectedTab = Nothing
      , section = Home
      , layout = Layout.init
      , sections = initialSections
      , search = ""
      , window = { width = 1000, height = 1000 }
      }
    , Cmd.none
    )


initialSections : Select Msg
initialSections =
    { selected = Nothing
    , options =
        [ { text = "Home", icon = Element.none }
        , { text = "Casinos", icon = Element.none }
        , { text = "Help", icon = Icon.book }
        ]
    , onSelect = SectionSelect >> identity >> Just
    }


type Msg
    = Resized { width : Int, height : Int }
    | Click
    | GotGreeting (Result Http.Error Greeting)
    | ChangedTab Int
    | ChangedSidebar (Maybe Layout.Part)
    | SectionSelect Int
    | Load String
    | ChangedSearch String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resized window ->
            ( { model | window = window }
            , Cmd.none
            )

        Click ->
            ( model
            , Api.getGreeting GotGreeting
            )

        GotGreeting (Ok greeting) ->
            ( { model | greeting = greeting }, Cmd.none )

        GotGreeting (Err error) ->
            ( { model | greeting = { id = -1, content = Debug.toString error } }, Cmd.none )

        ChangedTab tabNo ->
            ( { model | selectedTab = Just tabNo }, Cmd.none )

        ChangedSidebar sidebar ->
            ( { model | layout = model.layout |> Layout.activate sidebar }, Cmd.none )

        SectionSelect n ->
            ( { model | section = sectionFromInt n, layout = model.layout |> Layout.activate Nothing }, Cmd.none )

        Load string ->
            ( model, Navigation.load string )

        ChangedSearch string ->
            ( { model | search = string }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Layout.view materialStyle.layout
        { window = model.window
        , dialog = Nothing
        , layout = model.layout
        , title = el [] <| text "Da Portal"
        , menu = model.sections
        , search =
            Just
                { text = model.search
                , onChange = ChangedSearch
                , label = "Search"
                }
        , actions =
            [ { onPress = Just <| Load "https://github.com/netent-tech/elm-micronaut-example"
              , text = "Github"
              , icon = Icon.github
              }
            ]
        , onChangedSidebar = ChangedSidebar
        }
        (viewContent model)


viewContent : Model -> Element Msg
viewContent model =
    column materialStyle.column
        [ Element.el [ Element.height <| Element.px <| 42 ] <| Element.none
        , case model.section of
            Casinos ->
                viewCasinosSection model

            Home ->
                viewHomeSection model

            Help ->
                viewHelpSection model
        ]


viewCasinosSection : Model -> Element Msg
viewCasinosSection model =
    tab materialStyle.tab
        { tabs =
            { selected = model.selectedTab
            , options = tabs
            , onSelect = ChangedTab >> identity >> Just
            }
        , content =
            \s ->
                case s of
                    Just 0 ->
                        Element.text "first tab"

                    Just 1 ->
                        viewGreeting model

                    Just 2 ->
                        Element.text "third tab"

                    _ ->
                        Element.text "Select a tab"
        }


tabs : List { text : String, icon : Element Never }
tabs =
    [ "First", "Greet", "Third" ]
        |> List.map
            (\title ->
                { text = title
                , icon = Element.none
                }
            )


viewGreeting : Model -> Element Msg
viewGreeting model =
    column materialStyle.column
        [ row materialStyle.row
            [ text "Id: "
            , text <| String.fromInt model.greeting.id
            ]
        , row materialStyle.row
            [ text "Content: "
            , text model.greeting.content
            ]
        , viewButton
        ]


viewButton : Element Msg
viewButton =
    textButton materialStyle.primaryButton { onPress = Just Click, text = "Greet" }


viewHomeSection : Model -> Element Msg
viewHomeSection _ =
    column materialStyle.column [ text "This is the home section" ]


viewHelpSection : Model -> Element Msg
viewHelpSection _ =
    column materialStyle.column [ text "This is the Help section" ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onResize (\h w -> Resized { height = h, width = w })
