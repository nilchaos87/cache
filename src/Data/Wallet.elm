module Data.Wallet exposing (Wallet, new, save, restore)

import Http exposing (Error)
import Json.Decode exposing (Value)
import Data.Balance as Balance
import Data.Wallet.Persistence as Persistence exposing (PersistentWallet)


type alias Wallet =
    { address : String
    , balance : Maybe Float
    , error : Maybe String
    , expandError : Bool
    , fetchingBalance : Bool
    , class : Int
    }


new : (String -> Result Error Float -> msg) -> String -> ( Wallet, Cmd msg )
new msg address =
    ( { address = address
      , balance = Nothing
      , error = Nothing
      , expandError = False
      , fetchingBalance = True
      , class = 0
      }
    , Balance.fetch msg address
    )


save : List Wallet -> Cmd msg
save wallets =
    List.map toPersistentWallet wallets |> Persistence.save


toPersistentWallet : Wallet -> PersistentWallet
toPersistentWallet { address, class } =
    { address = address, class = class }


restore : (String -> Result Error Float -> msg) -> Value -> ( List Wallet, Cmd msg )
restore msg data =
    let
        wallets =
            List.map fromPersistentWallet <| Persistence.restore data

        addresses =
            List.map (\wallet -> wallet.address) wallets
    in
        ( wallets, Cmd.batch <| List.map (Balance.fetch msg) addresses )


fromPersistentWallet : PersistentWallet -> Wallet
fromPersistentWallet { address, class } =
    { address = address
    , balance = Nothing
    , error = Nothing
    , expandError = False
    , fetchingBalance = True
    , class = class
    }
