"use strict";

// Cross-Browser-Alias
const api = typeof browser !== "undefined" ? browser : chrome;

// Diese Funktion wird IN die aktive Webseite injiziert.
// Sie liest die Markierung, entfernt die Farb-Tags und kopiert das Ergebnis.
function cleanSelectionInPage() {
  const selection = window.getSelection ? window.getSelection().toString() : "";
  if (!selection) {
    return;
  }

  const cleaned = selection.replace(/\{color(?::[^}]*)?\}/gi, "");

  const showToast = (message) => {
    const toast = document.createElement("div");
    toast.textContent = message;
    Object.assign(toast.style, {
      position: "fixed",
      zIndex: "2147483647",
      right: "16px",
      bottom: "16px",
      padding: "10px 14px",
      background: "#27293d",
      color: "#e6e6f0",
      font: "13px/1.4 system-ui, sans-serif",
      border: "1px solid #3a3d5c",
      borderRadius: "8px",
      boxShadow: "0 4px 14px rgba(0,0,0,0.35)",
      opacity: "0",
      transition: "opacity 0.15s ease"
    });
    document.body.appendChild(toast);
    requestAnimationFrame(() => (toast.style.opacity = "1"));
    setTimeout(() => {
      toast.style.opacity = "0";
      setTimeout(() => toast.remove(), 200);
    }, 1500);
  };

  navigator.clipboard.writeText(cleaned).then(
    () => showToast("UnColor: bereinigt und kopiert"),
    () => showToast("UnColor: Kopieren fehlgeschlagen")
  );
}

api.commands.onCommand.addListener(async (command) => {
  if (command !== "clean-selection") {
    return;
  }

  const [tab] = await api.tabs.query({ active: true, currentWindow: true });
  if (!tab || !tab.id) {
    return;
  }

  try {
    await api.scripting.executeScript({
      target: { tabId: tab.id },
      func: cleanSelectionInPage
    });
  } catch (err) {
    // z. B. auf internen Seiten (about:, addons.mozilla.org) nicht erlaubt
    console.warn("UnColor: Injektion nicht möglich auf dieser Seite.", err);
  }
});
