import { Main } from './Main';
import "./styles";

const addresses = JSON.parse(localStorage.getItem('addresses') || "[]");

function save(addresses) {
    try {
        localStorage.setItem('addresses', JSON.stringify(addresses));
    }
    catch (e) {
        console.error(e);
    }
}

const meta = document.createElement('meta');
meta.name = 'viewport';
meta.content = 'width=device-width, initial-scale=1';
document.head.appendChild(meta);

const app = Main.
    fullscreen({ wallets: wallets() })
    .ports
    .wallets
    .subscribe(wallets);

function wallets(data) {
    if (data) {
        localStorage.setItem('wallets', JSON.stringify(data));
        return data;
    }

    const [addresses, wallets] = ['addresses', 'wallets'].map(key => JSON.parse(localStorage.getItem(key) || '[]'));

    if (wallets) {
        return wallets;
    }

    if (addresses) {
        return wallets(JSON.stringify(addresses.map(address => ({ address, 'class': 0 }))));
    }

    return [];
}
