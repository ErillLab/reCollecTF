import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { CurationProvider } from "./context/CurationContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <CurationProvider>
      <App />
    </CurationProvider>
  </React.StrictMode>
);

 