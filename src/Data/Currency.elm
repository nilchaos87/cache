module Data.Currency exposing (..)


type Currency
    = Bitcoin
    | Litecoin
    | Decred
    | EthereumClassic


currency : String -> Currency
currency address =
    let
        prefix =
            String.left 1 address
    in
        if prefix == "L" then
            Litecoin
        else if prefix == "D" then
            Decred
        else if prefix == "0" then
            EthereumClassic
        else
            Bitcoin


code : Currency -> String
code currency =
    case currency of
        Bitcoin ->
            "BTC"

        Litecoin ->
            "LTC"

        Decred ->
            "DCR"

        EthereumClassic ->
            "ETC"
