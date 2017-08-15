module Model exposing (Model)

import Data.Wallet exposing (Wallet)


type alias Model =
    { wallets : List Wallet
    , newAddress : String
    }
