# UnColor

## Zusammenfassung

Entfernt Farb-Tags wie {color} oder {color:#000000}, die Texte unleserlich machen. Text markieren, Hotkey drücken (Strg+Shift+U) – das Ergebnis liegt sofort sauber in der Zwischenablage. Alternativ Text ins Popup einfügen und bereinigen.

## Beschreibung

Kennst du das? In Jira-Tickets verstecken sich überall Farb-Tags wie {color:#ff0000}…{color}, die beim Kopieren mitkommen und den Text unleserlich machen. UnColor räumt das in einem Schritt auf.

So funktioniert es:

1) Schnellweg über Hotkey

- Text auf einer beliebigen Seite markieren
- Strg+Shift+U drücken
- Die bereinigte Version liegt sofort in der Zwischenablage – einfach mit Strg+V einfügen

1) Popup

- Auf das UnColor-Symbol in der Symbolleiste klicken
- Text einfügen, „Bereinigen" klicken, „Kopieren"

Was entfernt wird:

- {color}
- {color:#000000} und andere Hex-Farben
- {color:red} und benannte Farben

Der eigentliche Text bleibt vollständig erhalten – nur die Tags verschwinden.

Datenschutz: UnColor sendet keine Daten, sammelt nichts und kommuniziert mit keinem Server. Alles passiert lokal in deinem Browser.

## Datenschutz-Hinweis

Diese Erweiterung sammelt, speichert oder überträgt keinerlei Daten. Die Verarbeitung des markierten bzw. eingefügten Textes erfolgt ausschließlich lokal im Browser.

## Berechtigungen – Begründung

- scripting / activeTab: nötig, um den auf der aktiven Seite markierten Text per Hotkey zu lesen und zu bereinigen. Erst nach der Nutzeraktion (Hotkey) aktiv.
- clipboardWrite: nötig, um das bereinigte Ergebnis in die Zwischenablage zu legen.

## Support-/Homepage-URL

– <https://github.com/pixo2000/UnColor>

## Disclaimer

Ich hab das Addon in 10 Minuten mit KI erstellt um nur schnell ne Lösugn zu haben!
