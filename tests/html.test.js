const fs = require("fs");
const path = require("path");

describe("HTML Files Structure", () => {
  const websiteIndexHtml = fs.readFileSync(
    path.join(__dirname, "..", "website", "index.html"),
    "utf8"
  );
  const errorHtml = fs.readFileSync(
    path.join(__dirname, "..", "website", "404.html"),
    "utf8"
  );
  const redirectIndexHtml = fs.readFileSync(
    path.join(__dirname, "..", "index.html"),
    "utf8"
  );

  describe("website/index.html", () => {
    test("should have required meta tags", () => {
      expect(websiteIndexHtml).toMatch(/<meta charset="UTF-8"/);
      expect(websiteIndexHtml).toMatch(/<meta name="viewport"/);
      expect(websiteIndexHtml).toMatch(
        /<title>DevOps na Prática - Fase 1<\/title>/
      );
    });

    test("should have main structural elements", () => {
      expect(websiteIndexHtml).toMatch(/<div class="container"/);
      expect(websiteIndexHtml).toMatch(/<h1>DevOps na Prática - Fase 1<\/h1>/);
      expect(websiteIndexHtml).toMatch(
        /✅ Deploy automático configurado com sucesso!/
      );
    });

    test("should list project features", () => {
      expect(websiteIndexHtml).toMatch(/Hospedagem no Amazon S3/);
      expect(websiteIndexHtml).toMatch(/Deploy automático via GitHub Actions/);
      expect(websiteIndexHtml).toMatch(
        /Infraestrutura como Código com Terraform/
      );
      expect(websiteIndexHtml).toMatch(
        /Integração Contínua e Entrega Contínua \(CI\/CD\)/
      );
    });
  });

  describe("website/404.html", () => {
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

  describe("root/index.html (Redirect Page)", () => {
    test("should have required meta tags", () => {
      expect(redirectIndexHtml).toMatch(/<meta charset="UTF-8"/);
      expect(redirectIndexHtml).toMatch(/<meta name="viewport"/);
      expect(redirectIndexHtml).toMatch(
        /<meta http-equiv="refresh" content="0; url=website\/index.html"/
      );
      expect(redirectIndexHtml).toMatch(/<title>Redirecionando\.\.\.<\/title>/);
    });

    test("should have JavaScript redirect", () => {
      expect(redirectIndexHtml).toMatch(
        /window\.location\.href = "website\/index\.html"/
      );
    });

    test("should have fallback link", () => {
      expect(redirectIndexHtml).toMatch(
        /<a href="website\/index\.html">clique aqui<\/a>/
      );
      expect(redirectIndexHtml).toMatch(
        /Se você não for redirecionado automaticamente/
      );
    });

    test("should have proper HTML structure", () => {
      expect(redirectIndexHtml).toMatch(/<!DOCTYPE html>/);
      expect(redirectIndexHtml).toMatch(/<html lang="pt-BR">/);
      expect(redirectIndexHtml).toMatch(/<head>/);
      expect(redirectIndexHtml).toMatch(/<body>/);
    });
  });
});
