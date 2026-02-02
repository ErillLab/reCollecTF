/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",

    "./curation-pipeline/index.html",
    "./curation-pipeline/src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
        colors: {
            bg: "#1e1e1e",
            surface: "#2a2a2a",
            text: "#f5f5f5",
            accent: "#4fc3f7",
            muted: "#b0b0b0",
            border: "#444",
            hover: "#3a3a3a",
        },
        borderRadius: {
            DEFAULT: "8px",
        },
        padding: {
            layout: "5rem",
        },
        fontFamily: {
            sans: ["Segoe UI", "sans-serif"],
        },
    },
  },
  plugins: [],
}