# --- Estágio 1: Build (Construção) ---
# Usamos uma imagem com Maven e Java 17 para compilar o código
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Define a pasta de trabalho dentro do container
WORKDIR /app

# Copia apenas o pom.xml primeiro (para aproveitar o cache de dependências)
COPY pom.xml .

# Baixa as dependências (isso acelera builds futuros)
RUN mvn dependency:go-offline

# Copia o código fonte do projeto
COPY src ./src

# Compila o projeto e gera o arquivo .jar (pulando testes aqui para ser mais rápido)
RUN mvn clean package -DskipTests

# --- Estágio 2: Runtime (Execução) ---
# Usamos uma imagem leve (Slim) apenas com o Java 17 para rodar a aplicação
FROM eclipse-temurin:17-jre-alpine

# Define a pasta de trabalho
WORKDIR /app

# Copia o .jar gerado no estágio anterior (build) para cá
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta 8080 (padrão do Spring Boot)
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]