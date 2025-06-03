const fs = require("fs");
const path = require("path");

describe("HTML Files Structure", () => {
  const indexHtml = fs.readFileSync(
    path.join(__dirname, "..", "website", "index.html"),
    "utf8"
  );
  const errorHtml = fs.readFileSync(
    path.join(__dirname, "..", "website", "404.html"),
    "utf8"
  );

  describe("index.html", () => {
    test("should have required meta tags", () => {
      expect(indexHtml).toMatch(/<meta charset="UTF-8"/);
      expect(indexHtml).toMatch(/<meta name="viewport"/);
      expect(indexHtml).toMatch(/<title>DevOps na Prática - Fase 1<\/title>/);
    });

    test("should have main structural elements", () => {
      expect(indexHtml).toMatch(/<div class="container"/);
      expect(indexHtml).toMatch(/<h1>DevOps na Prática - Fase 1<\/h1>/);
      expect(indexHtml).toMatch(
        /✅ Deploy automático configurado com sucesso!/
      );
    });

    test("should list project features", () => {
      expect(indexHtml).toMatch(/Hospedagem no Amazon S3/);
      expect(indexHtml).toMatch(/Deploy automático via GitHub Actions/);
      expect(indexHtml).toMatch(/Infraestrutura como Código com Terraform/);
      expect(indexHtml).toMatch(
        /Integração Contínua e Entrega Contínua \(CI\/CD\)/
      );
    });
  });

  describe("404.html", () => {
    test("should have required meta tags", () => {
      expect(errorHtml).toMatch(/<meta charset="UTF-8"/);
      expect(errorHtml).toMatch(/<meta name="viewport"/);
      expect(errorHtml).toMatch(
        /<title>Página não encontrada - DevOps na Prática<\/title>/
      );
    });

    test("should have error message elements", () => {
      expect(errorHtml).toMatch(/<p class="error-code">404<\/p>/);
      expect(errorHtml).toMatch(/<h1>Página não encontrada<\/h1>/);
      expect(errorHtml).toMatch(
        /A página que você está procurando não existe ou foi movida/
      );
    });

    test("should have back link", () => {
      expect(errorHtml).toMatch(
        /<a href="\/" class="back-link">Voltar para a página inicial<\/a>/
      );
    });
  });
});
