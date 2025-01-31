# Checklist de Segurança

Este checklist ajuda a garantir que seu projeto está protegido.

## Código e Dependências
- [ ] Verificar vulnerabilidades no código Python (`scan_python_security.sh`)
- [ ] Verificar segredos expostos (`scan_secrets.sh`)

## Infraestrutura
- [ ] Verificar segurança em configurações Terraform (`scan_tfsec.sh`)
- [ ] Analisar vulnerabilidades em imagens Docker (`scan_docker_security.sh`)

## Revisão e Auditoria
- [ ] Revisar logs de auditoria regularmente
- [ ] Implementar autenticação multifator (MFA)
- [ ] Atualizar dependências frequentemente
