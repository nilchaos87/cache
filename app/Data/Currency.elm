module Data.Currency exposing (Currency(Bitcoin, Litecoin, Decred), currency)


type Currency
    = Bitcoin
    | Litecoin
    | Decred


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
        else
            Bitcoin
