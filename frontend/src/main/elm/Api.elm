module Api exposing (..)

import Http
import Json.Decode exposing (Decoder)


type alias Greeting =
    { id : Int
    , content : String
    }


getGreeting : (Result Http.Error Greeting -> msg) -> Cmd msg
getGreeting msg =
    Http.get
        { url = "/greeting"
        , expect = Http.expectJson msg greetingDecoder
        }


greetingDecoder : Decoder Greeting
greetingDecoder =
    Json.Decode.map2 Greeting
        (Json.Decode.field "id" Json.Decode.int)
        (Json.Decode.field "content" Json.Decode.string)
