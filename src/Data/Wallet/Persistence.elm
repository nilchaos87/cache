port module Data.Wallet.Persistence exposing (PersistentWallet, save, restore)

import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, decodeValue, map2, field)


port wallets : Value -> Cmd msg


type alias PersistentWallet =
    { address : String
    , class : Int
    }


save : List PersistentWallet -> Cmd msg
save =
    encoder >> wallets


restore : Value -> List PersistentWallet
restore data =
    case (decodeValue decoder data) of
        Ok wallets ->
            wallets

        Err _ ->
            []


encoder : List PersistentWallet -> Value
encoder wallets =
    Encode.list <| List.map encodeWallet wallets


encodeWallet : PersistentWallet -> Value
encodeWallet { address, class } =
    Encode.object <| [ ( "address", Encode.string address ), ( "class", Encode.int class ) ]


decoder : Decoder (List PersistentWallet)
decoder =
    map2 PersistentWallet (field "address" Decode.string) (field "class" Decode.int) |> Decode.list
