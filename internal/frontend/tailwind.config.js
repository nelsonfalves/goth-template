/** @type {import('tailwindcss').Config} */
module.exports = {
     content: ["./internal/frontend/templates/**/*.templ"],
     theme: {
          extend: {
               boxShadow: {
                    custom: "0px 10px 25px rgba(0, 0, 0, 0.7)",
               },
          },
     },
     plugins: [],
};
