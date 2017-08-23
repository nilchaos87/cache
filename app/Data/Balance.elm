module Data.Balance exposing (fetch)

import Http exposing (Error)
import Data.Balance.Bitcoin as BitcoinBalance
import Data.Balance.Litecoin as LitecoinBalance
import Data.Balance.Decred as DecredBalance
import Data.Balance.EthereumClassic as EthereumClassicBalance
import Data.Currency exposing (Currency(Bitcoin, Litecoin, Decred, EthereumClassic), currency)


fetch : (String -> Result Error Float -> msg) -> String -> Cmd msg
fetch msg address =
    case (currency address) of
        Bitcoin ->
            BitcoinBalance.fetch msg address

        Litecoin ->
            LitecoinBalance.fetch msg address

        Decred ->
            DecredBalance.fetch msg address

        EthereumClassic ->
            EthereumClassicBalance.fetch msg address
