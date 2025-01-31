echo "Executando análise de segurança em infraestrutura com TFSec"

MODE=${1:-summary}

tfsec --format=json --out=security/tfsec_report.json

if [[ "$MODE" == "summary" ]]; then
    echo "Resumo:"
    cat security/tfsec_report.json | jq -r '.results[]? | "\(.severity): \(.description) [\(.location.filename)]"'
else
    echo "Relatório completo salvo em security/tfsec_report.json"
fi

echo "Análise de segurança em Terraform concluída"
