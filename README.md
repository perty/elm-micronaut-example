# elm-micronaut-example

An example of a full stack micro service with a frontend in Elm and backend in Micronaut and Java.

Frontend uses [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/1.1.7/) with 
[elm-ui-widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/2.0.1/) 
for a [Material](https://material.io/) design. 

## Building and running locally

To start the application, use `./gradlew run`. This will build the frontend and backend and start the service.
The first time it will be slow as it has to do some downloading,
but the round trip should be less than 2 seconds thereafter.

## Structure

There are two parts, the frontend and the backend. The backend depends on the frontend 
which may look weird but that is because
it serves the web gui when accessing root, therefore the client must be built first.

