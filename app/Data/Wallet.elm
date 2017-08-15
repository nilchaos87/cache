module Data.Wallet exposing (Wallet, wallet)


type alias Wallet =
    { address : String
    , balance : Maybe Float
    , error : Maybe String
    }


wallet : String -> Wallet
wallet address =
    { address = address
    , balance = Nothing
    , error = Nothing
    }
