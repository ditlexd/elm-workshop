module Model exposing (..)

type CardState = Open | Closed | Matched
type Group = A | B
type GameState = Choosing | Matching Card | GameOver 

type alias Card = { id : String, state : CardState, group : Group}
type alias Deck = List Card

type alias Model = { cards : Deck, state : GameState }

type Msg = CardClick Card