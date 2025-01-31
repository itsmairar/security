# Security Automation

Este repositório contém scripts e automações para melhorar a segurança do código-fonte, infraestrutura e workflows. Ele ajuda a identificar vulnerabilidades antes que cheguem à produção.

## Quando Usar este Repositório?

-   Antes de subir código para produção (CI/CD)
-   Durante auditorias de segurança
-   Para validar imagens Docker e infraestrutura como código
-   Para detectar credenciais e segredos vazados
-   Como parte de um processo DevSecOps automatizado

## Estrutura do Repositório

```
│── security-scripts/        # Scripts para análises de segurança
│   ├── security/        # Relatórios de segurança gerados pelos scans
│   ├── scan_python_security.sh   # Escaneia vulnerabilidades em código Python
│   ├── scan_docker_security.sh   # Escaneia vulnerabilidades em imagens Docker
│   ├── scan_secrets.sh           # Verifica credenciais vazadas
│   ├── scan_tfsec.sh             # Analisa segurança de infraestrutura Terraform
│
│── .github/workflows/       # CI/CD para rodar os scans automaticamente
│   ├── security-scan.yml    # Workflow do GitHub Actions
│
│── docs/                    # Documentação
│   ├── SECURITY.md          # Diretrizes gerais de segurança
│   ├── security-checklist.md # Checklist de segurança
│   ├── security-issue.md     # Modelo para reportar problemas de segurança
│
│── docker/                  # Configuração Docker
│   ├── Dockerfile           # Arquivo para criação da imagem Docker
│
│── terraform/               # Configuração Terraform
│   ├── terraform.tf         # Definições de infraestrutura como código

```

## Como Usar

### Instalar Dependências

Antes de rodar os scripts, instale as dependências:

```bash
sudo apt update && sudo apt install -y jq trivy gitleaks
pip install bandit

```

### Criar a Pasta de Relatórios

Os relatórios serão salvos em `security/`. Para evitar erros:

```bash
mkdir -p security

```

### Executar os Scans de Segurança

```bash
bash security-scripts/scan_python_security.sh
bash security-scripts/scan_docker_security.sh
bash security-scripts/scan_secrets.sh
bash security-scripts/scan_tfsec.sh

```

### Executar via GitHub Actions

O workflow `security-scan.yml` roda automaticamente em cada `push` e `pull request`. Para rodar manualmente:

1.  Vá até a aba **Actions** no GitHub.
2.  Escolha **Security Scan**.
3.  Clique em **Run workflow**.

### Executando via GitHub Actions

## Lendo os Relatórios

Os relatórios são gerados em formato JSON na pasta `security/`.

-   **Bandit (Python)**: `security/bandit_report.json`
-   **Trivy (Docker)**: `security/trivy_report.json`
-   **Gitleaks (Segredos)**: `security/gitleaks_report.json`
-   **Tfsec (Terraform)**: `security/tfsec_report.json`

Para visualizar:

```bash
cat security-reports/bandit_report.json | jq '.'

```

Se o relatório for muito grande:

```bash
tail -n 50 security-reports/bandit_report.json

```

## Personalização

### Editando os scripts

Os scripts podem ser ajustados para atender às necessidades do seu projeto. Exemplos:

-   Modificar a severidade dos alertas do **Bandit** (`--severity-level high` → `medium`)
-   Alterar a imagem-alvo no **Trivy** (`meu-projeto` → `minha-imagem`)
-   Adicionar regras personalizadas ao **Gitleaks**

## O Que Fazer se os Relatórios Estiverem Grandes Demais?

Se os logs ocuparem muito espaço no terminal:

1.  **Visualizar apenas os últimos 50 logs**:
    
    ```bash
    tail -n 50 security/trivy_report.json
    
    ```
    
2.  **Filtrar apenas os erros críticos com `jq`**:
    
    ```bash
    cat security/trivy_report.json | jq '.[] | select(.severity=="CRITICAL")'
    
    ```
    
3.  **Exportar para um arquivo menor:**
    
    ```bash
    cat security/trivy_report.json | jq '.[] | select(.severity=="HIGH")' > security-reports/high_severity.json
    
    ```

### Alternativa com Aqua Trivy

Se desejar uma solução mais simples e integrada, você pode utilizar o **Aqua Trivy**, que combina várias verificações de segurança em um único scanner:

-   **Verificação de vulnerabilidades** em código-fonte.
    
-   **Escaneamento de infraestrutura como código** (Docker, Terraform, Kubernetes).
    
-   **Detecção de segredos expostos**.
    

#### Como rodar Trivy localmente:

```
sudo apt update
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh
trivy fs --severity HIGH,CRITICAL --scanners vuln,secret .
```

#### Como integrar com GitHub Actions:

```
- name: Run Trivy Security Scan
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'meu-projeto'
```
#### Se a saída for muito longa e quiser ver apenas as **CRÍTICAS**, rode:

```
trivy fs --severity CRITICAL --scanners vuln,secret .
```

Para salvar o relatório em um arquivo JSON:
```
trivy fs --severity HIGH,CRITICAL --scanners vuln,secret . -f json -o trivy-report.json
```

Isso pode ser uma alternativa para quem busca uma configuração mais simples e rápida para automação de segurança.
