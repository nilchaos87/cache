module Data.Wallet exposing (..)

import Http exposing (Error)
import Data.Balance as Balance


type alias Wallet =
    { address : String
    , balance : Maybe Float
    , error : Maybe String
    , expandError : Bool
    , fetchingBalance : Bool
    , class : Int
    }


wallet : (String -> Result Error Float -> msg) -> String -> ( Wallet, Cmd msg )
wallet msg address =
    ( { address = address
      , balance = Nothing
      , error = Nothing
      , expandError = False
      , fetchingBalance = True
      , class = 0
      }
    , Balance.fetch msg address
    )
