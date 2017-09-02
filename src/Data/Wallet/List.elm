module Data.Wallet.List exposing (Wallets, moveUp, moveDown)

import Data.Wallet exposing (Wallet)


type alias Wallets =
    List Wallet


moveUp : Wallet -> Wallets -> Wallets
moveUp { order } wallets =
    List.map (reorder order (order - 1)) wallets


moveDown : Wallet -> Wallets -> Wallets
moveDown { order } wallets =
    List.map (reorder order (order + 1)) wallets


reorder : Int -> Int -> Wallet -> Wallet
reorder from to wallet =
    if (wallet.order == from) then
        { wallet | order = to }
    else if (wallet.order == to) then
        { wallet | order = from }
    else
        wallet


justBefore : Int -> Wallet -> Bool
justBefore order wallet =
    wallet.order == order - 1


justAfter : Int -> Wallet -> Bool
justAfter order wallet =
    wallet.order == order + 1
