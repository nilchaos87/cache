module Data.Currency exposing (Currency(Bitcoin, Litecoin), currency)


type Currency
    = Bitcoin
    | Litecoin


currency : String -> Currency
currency address =
    if (String.left 1 address == "L") then
        Litecoin
    else
        Bitcoin
