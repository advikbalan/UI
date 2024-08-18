const express = require('express');
const path = require('path');

const app = express();

// Serve the static files from the `dist` directory
app.use(express.static(path.join(__dirname, 'dist/angular-project1/browser')));

// Redirect all other routes to `index.html`
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist/angular-project1/browser/index.html'));
});

// Start the server on port 8080 or the port provided in environment variables
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
