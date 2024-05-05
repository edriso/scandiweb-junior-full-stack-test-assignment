/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    colors: {
      accent: '#5ECE7B',
      text: '#1D1F22',
    },
    fontFamily: {
      raleway: ['Raleway', 'system-ui', 'sans-serif'],
      roboto: ['Roboto', 'system-ui', 'sans-serif'],
    },
  },
  plugins: [],
};
