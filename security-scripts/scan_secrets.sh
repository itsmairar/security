echo "Verificando exposição de credenciais com Gitleaks"

MODE=${1:-summary}

gitleaks detect --source . --verbose --report-format=json --report-path=security/gitleaks_report.json

if [[ "$MODE" == "summary" ]]; then
    echo "Resumo:"
    cat security/gitleaks_report.json | jq -r '.leaks[]? | "\(.rule): \(.file)"'
else
    echo "Relatório completo salvo em security/gitleaks_report.json"
fi

echo "Verificação de segredos finalizada"
