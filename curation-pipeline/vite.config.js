import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'

import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Middleware per evitar compressió gzip en fitxers .db i .gz
function noCompressDbMiddleware() {
  return (req, res, next) => {
    if (req.url && (req.url.endsWith('.db') || req.url.endsWith('.gz'))) {
      // Deshabilitem la compressió per a aquesta petició
      // Una manera és definir una propietat que connect-compression llegeix:
      res.setHeader('Content-Encoding', 'identity') 
    }
    next()
  }
}
// https://vite.dev/config/
export default defineConfig({
  plugins: [react(),
     {
      name: 'vite-plugin-range-requets',
      configureServer(server) {
        server.middlewares.use(noCompressDbMiddleware())
        server.middlewares.use((req, res, next) => {
          if (req.url && (req.url.endsWith('.db') || req.url.endsWith('.gz'))) {
            res.setHeader('Accept-Ranges', 'bytes')
          }
          next()
        })
      }
    
    }
  ],
  base: "/reCollecTF/",
  build: {
    rollupOptions: {
      external: ['fsevents']
    }
  },

  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },

})
