module Data.Balance exposing (fetch)

import Http exposing (Error, send, get)
import Json.Decode exposing (Decoder)
import Data.Balance.Bitcoin as BitcoinBalance
import Data.Balance.Litecoin as LitecoinBalance
import Data.Balance.Decred as DecredBalance
import Data.Balance.EthereumClassic as EthereumClassicBalance
import Data.Currency exposing (Currency(Bitcoin, Litecoin, Decred, EthereumClassic), currency)


fetch : (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch msg address =
    let
        { endpoint, decoder } =
            request address
    in
        send (msg address) <| get endpoint decoder


request : String -> { endpoint : String, decoder : Decoder Float }
request address =
    case (currency address) of
        Bitcoin ->
            { endpoint = BitcoinBalance.url address
            , decoder = BitcoinBalance.decoder
            }

        Litecoin ->
            { endpoint = LitecoinBalance.url address
            , decoder = LitecoinBalance.decoder
            }

        Decred ->
            { endpoint = DecredBalance.url address
            , decoder = DecredBalance.decoder
            }

        EthereumClassic ->
            { endpoint = EthereumClassicBalance.url address
            , decoder = EthereumClassicBalance.decoder
            }
