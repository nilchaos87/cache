#!/bin/sh

elm-make app/Main.elm --output=main.js
lessc styles.less styles.css
