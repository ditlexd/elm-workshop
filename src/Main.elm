module Main exposing (main)

import Browser
import DeckGenerator exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


myCards : Deck
myCards =
    [ { id = "1", state = Closed, group = A }, { id = "2", state = Closed, group = A }, { id = "3", state = Closed, group = A }, { id = "4", state = Closed, group = A }, { id = "5", state = Closed, group = A }, { id = "6", state = Closed, group = A }, { id = "1", state = Closed, group = B }, { id = "2", state = Closed, group = B }, { id = "3", state = Closed, group = B }, { id = "4", state = Closed, group = B }, { id = "5", state = Closed, group = B }, { id = "6", state = Closed, group = B } ]


viewCard : Card -> Html Msg
viewCard card =
    case card.state of
        Open ->
            div [] [ img [ src ("/cats/" ++ card.id ++ ".png") ] [] ]

        Closed ->
            div [ onClick (CardClick card) ] [ img [ src ("/cats/" ++ "closed" ++ ".png") ] [] ]

        Matched ->
            div [] [ img [ src ("/cats/" ++ card.id ++ ".png") ] [] ]


viewCards : Deck -> Html Msg
viewCards list =
    div [ class "cards" ] (List.map viewCard list)


init : Model
init =
    { cards = myCards, state = Choosing myCards }


view : Model -> Html Msg
view model =
    viewCards model.cards


setCard : CardState -> Card -> Card
setCard state card =
    { card | state = state }


update : Msg -> Model -> Model
update message model =
    case message of
        CardClick card ->
            { model
                | cards =
                    List.map
                        (\element ->
                            if element.state == Closed && element.id == card.id && card.group == element.group then
                                setCard Open element

                            else
                                element
                        )
                        model.cards
                , state = updateCardClick model.state
            }


closeUnmatched : Deck -> Deck
closeUnmatched deck =
    List.map
        (\element ->
            if element.state /= Matched then
                { element | state = Closed }

            else
                element
        )
        deck


updateCardClick : GameState -> GameState
updateCardClick gameState =
    case gameState of
        Matching card ->
            Choosing 
     
        Choosing   ->
            Matching 
        
        GameOver ->
            GameOver

