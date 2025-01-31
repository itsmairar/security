echo "Verificando vulnerabilidades na imagem Docker"

MODE=${1:-summary}
# Substitua
IMAGE_NAME=${2:-"meu projeto"}

trivy image --ignore-unfixed --format json -o security/trivy_report.json $IMAGE_NAME

if [[ "$MODE" == "summary" ]]; then
    echo "Resumo:"
    cat security/trivy_report.json | jq -r '.Results[].Vulnerabilities[]? | "\(.Severity): \(.Title) [\(.PkgName)]"'
else
    echo "Relatório completo salvo em security/trivy_report.json"
fi

echo "Análise de segurança no Docker concluída"
