// Returns the API host depending on the environment
// In Vite/browser, VITE_API_URL will be replaced at build time
// In Jest/Node, use process.env or default

let API_HOST = 'http://localhost:8081';

// Vite replaces import.meta.env at build time, so this will work in browser
// But do NOT reference import.meta directly in Node/Jest
if (typeof process !== 'undefined' && process.env && process.env.VITE_API_URL) {
  API_HOST = process.env.VITE_API_URL;
}

export default API_HOST;
