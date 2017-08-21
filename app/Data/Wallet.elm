module Data.Wallet exposing (Wallet, wallet)


type alias Wallet =
    { address : String
    , balance : Maybe Float
    , error : Maybe String
    , expandError : Bool
    , fetchingBalance : Bool
    }


wallet : String -> Bool -> Wallet
wallet address fetchingBalance =
    { address = address
    , balance = Nothing
    , error = Nothing
    , expandError = False
    , fetchingBalance = fetchingBalance
    }
