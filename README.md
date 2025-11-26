# DevOps Java Pipeline Practice

Este projeto é uma demonstração prática de uma esteira **CI/CD (Integração e Entrega Contínuas)** moderna para aplicações Java.

O objetivo foi transformar uma aplicação Spring Boot monolítica num container Docker otimizado, automatizando todo o processo de build, testes e publicação utilizando GitHub Actions.

## Tecnologias Utilizadas

* **Linguagem:** Java 17
* **Framework:** Spring Boot 3
* **Build Tool:** Maven
* **Containerização:** Docker (Multi-stage build)
* **CI/CD:** GitHub Actions
* **Registry:** GitHub Container Registry (GHCR)

## Como funciona a Pipeline

A automação está definida no arquivo `.github/workflows/pipeline.yml`. A cada `push` na branch `main`, os seguintes passos são executados automaticamente:

1.  **Checkout & Setup:** Configuração do ambiente Ubuntu com Java 17.
2.  **Test & Verify:** Execução dos testes unitários e verificação de qualidade com Maven.
3.  **Docker Build:** Criação da imagem utilizando estratégia *Multi-stage* (separando a fase de compilação da fase de execução para imagens mais leves).
4.  **Publish:** Login automático e publicação da imagem Docker no GitHub Container Registry.

## Como rodar a imagem (para quem tem Docker)

Como a imagem é pública, qualquer pessoa pode baixar e rodar a aplicação sem precisar configurar o Java localmente:

```bash
# 1. Baixar a imagem mais recente
docker pull ghcr.io/brunoforde/devopsdemo:latest

# 2. Rodar a aplicação na porta 8080
docker run -p 8080:8080 ghcr.io/brunoforde/devopsdemo:latest
