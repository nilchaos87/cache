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
    fullscreen({ addresses })
    .ports
    .save
    .subscribe(save);
