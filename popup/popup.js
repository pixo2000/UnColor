"use strict";

const input = document.getElementById("input");
const cleanBtn = document.getElementById("clean");
const copyBtn = document.getElementById("copy");
const clearBtn = document.getElementById("clear");
const status = document.getElementById("status");

// Entfernt Farb-Tags der Form {color} und {color:#000000} bzw. {color:red}.
// Der eingeschlossene Text bleibt erhalten, nur die Tags werden gelöscht.
const COLOR_TAG = /\{color(?::[^}]*)?\}/gi;

function setStatus(message) {
  status.textContent = message;
}

function clean() {
  const original = input.value;
  if (!original) {
    setStatus("Kein Text vorhanden.");
    return;
  }

  const matches = original.match(COLOR_TAG);
  const count = matches ? matches.length : 0;

  input.value = original.replace(COLOR_TAG, "");

  setStatus(
    count === 0
      ? "Keine Farb-Tags gefunden."
      : `${count} Farb-Tag${count === 1 ? "" : "s"} entfernt.`
  );
}

async function copy() {
  if (!input.value) {
    setStatus("Kein Text zum Kopieren.");
    return;
  }
  try {
    await navigator.clipboard.writeText(input.value);
    setStatus("In die Zwischenablage kopiert.");
  } catch {
    input.select();
    setStatus("Kopieren nicht möglich – bitte manuell kopieren (Strg+C).");
  }
}

function clear() {
  input.value = "";
  setStatus("");
  input.focus();
}

cleanBtn.addEventListener("click", clean);
copyBtn.addEventListener("click", copy);
clearBtn.addEventListener("click", clear);

input.focus();
