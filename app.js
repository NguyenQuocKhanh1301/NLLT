const express = require("express");
const path = require("path");
const { exec } = require("child_process");

const app = express();

// Middleware to parse JSON body
app.use(express.json());

// Serve static files (your HTML, CSS, JS) from 'public' folder
app.use(express.static(path.join(__dirname, "public")));

app.post("/suggest", (req, res) => {
  if (!req.body.ingredients || !Array.isArray(req.body.ingredients)) {
    return res.status(400).send("Invalid ingredients format");
  }

  // Quote ingredients for Prolog safely
  const ingredients = req.body.ingredients.map(i => `'${i}'`).join(",");

  // Construct Prolog command
  const cmd = `swipl -s recipes.pl -g "findall(R, suggest_recipe([${ingredients}], R), List), writeln(List)." -t halt`;

  exec(cmd, (error, stdout, stderr) => {
    if (error) return res.status(500).send("Error: " + error.message);
    if (stderr) console.error("Prolog stderr:", stderr);

    const output = stdout.trim();
    if (!output.startsWith("[") || !output.endsWith("]")) {
      return res.status(500).send("Unexpected Prolog output");
    }

    // Parse Prolog list output safely
    const trimmed = output.slice(1, -1).trim(); // Remove [ and ]
    const suggestions = trimmed.length === 0
      ? []
      : trimmed.split(",").map(s => s.trim().replace(/^'|'$/g, ""));

    res.send({ suggestions });
  });
});

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
