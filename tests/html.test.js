const fs = require("fs");
const path = require("path");

describe("HTML Files Structure", () => {
  const indexHtml = fs.readFileSync(
    path.join(__dirname, "..", "index.html"),
    "utf8"
  );
  const errorHtml = fs.readFileSync(
    path.join(__dirname, "..", "404.html"),
    "utf8"
  );

  test("index.html should have required meta tags", () => {
    expect(indexHtml).toMatch(/<meta charset="UTF-8"/);
    expect(indexHtml).toMatch(/<meta name="viewport"/);
    expect(indexHtml).toMatch(/<title>DevOps na Prática - Fase 1<\/title>/);
  });

  test("index.html should have main structural elements", () => {
    expect(indexHtml).toMatch(/<header/);
    expect(indexHtml).toMatch(/<main/);
    expect(indexHtml).toMatch(/<footer/);
  });

  test("404.html should have required meta tags", () => {
    expect(errorHtml).toMatch(/<meta charset="UTF-8"/);
    expect(errorHtml).toMatch(/<meta name="viewport"/);
    expect(errorHtml).toMatch(
      /<title>Página Não Encontrada - DevOps na Prática<\/title>/
    );
  });

  test("404.html should have error message", () => {
    expect(errorHtml).toMatch(/404/);
    expect(errorHtml).toMatch(/Página não encontrada/i);
  });
});
