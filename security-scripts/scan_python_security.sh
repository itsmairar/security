echo "Executando análise de segurança no código Python"

MODE=${1:-summary}

bandit -r . --exclude venv,poetry.lock,*.egg-info --severity high --format json > security/bandit_report.json

if [[ "$MODE" == "summary" ]]; then
    echo "Resumo:"
    cat security/bandit_report.json | jq -r '.results[]? | "\(.severity): \(.issue_text) [\(.filename)]"'
else
    echo "Relatório completo salvo em security/bandit_report.json"
fi

echo "Análise de segurança concluída"
