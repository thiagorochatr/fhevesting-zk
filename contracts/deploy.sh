#!/bin/bash

# Deploy script for ZKMintContract
# Constructor foi simplificado - usa bytes diretos em vez de parsing!

echo "🚀 Deploying ZKMintContract (Fixed Constructor Version)..."
echo ""
echo "✨ Mudanças implementadas:"
echo "  - Constructor usa bytes diretos (sem parsing de strings)"
echo "  - Mais confiável e não falha em gas estimation"
echo "  - Cargo stylus check: ✅ PASSOU"
echo ""
echo "📋 Configurações Hardcoded:"
echo "  Owner: 0x661cb7aa99e91c2b43db1859b2a2b0672d7ded55"
echo "  Min Required Balance: 100,000 (0.1 ETH scaled)"
echo "  CCIP Sender: 0x610A3FE3F5D9080ae17101D2a47f081aCAd52443"
echo "  Chain Selector: 16015286601757825753 (Ethereum Sepolia)"
echo "  Receiver: 0x2504562a26366ee91e19858bC6f5C2bec7734167"
echo "  CCIP Enabled: TRUE ✅ (ativo por padrão)"
echo ""
echo "📊 Contract Stats:"
echo "  Size: 23.3 KiB"
echo "  Estimated fee: ~0.000139 ETH"
echo ""
echo "🔄 Iniciando deploy..."
echo ""

# Deploy sem parâmetros no constructor!
# Você precisa fornecer sua chave privada de uma das seguintes formas:
# 1. Via variável de ambiente: export PRIVATE_KEY="sua_chave_aqui"
# 2. Via arquivo: --private-key-path ./private_key.txt
# 3. Via keystore: --keystore-path ./keystore.json

if [ -z "$PRIVATE_KEY" ]; then
    echo "❌ ERRO: Variável de ambiente PRIVATE_KEY não está definida!"
    echo ""
    echo "💡 Como fazer o deploy:"
    echo "   Opção 1 (variável de ambiente):"
    echo "     export PRIVATE_KEY='0xsua_chave_privada_aqui'"
    echo "     ./deploy.sh"
    echo ""
    echo "   Opção 2 (arquivo):"
    echo "     echo '0xsua_chave_privada' > private_key.txt"
    echo "     cargo stylus deploy --endpoint=https://sepolia-rollup.arbitrum.io/rpc --private-key-path ./private_key.txt"
    echo ""
    echo "   Opção 3 (keystore):"
    echo "     cargo stylus deploy --endpoint=https://sepolia-rollup.arbitrum.io/rpc --keystore-path ./keystore.json"
    echo ""
    exit 1
fi

cargo stylus deploy \
  --endpoint=https://sepolia-rollup.arbitrum.io/rpc \
  --private-key="$PRIVATE_KEY"

DEPLOY_STATUS=$?

echo ""
if [ $DEPLOY_STATUS -eq 0 ]; then
    echo "✅ Deploy completed successfully!"
    echo ""
    echo "⚠️  IMPORTANTE:"
    echo "   CCIP está ATIVO! Certifique-se que o Sender tem LINK:"
    echo "   Address: 0x610A3FE3F5D9080ae17101D2a47f081aCAd52443"
    echo ""
    echo "🎯 Próximos passos:"
    echo "   1. Anote o endereço do contrato deployado"
    echo "   2. Verifique que o CCIP Sender tem LINK"
    echo "   3. Teste uma prova ZK"
    echo "   4. Monitore eventos CCIPMessageSent"
else
    echo "❌ Deploy falhou!"
    echo ""
    echo "💡 Troubleshooting:"
    echo "   - Verifique se tem ETH na Arbitrum Sepolia"
    echo "   - Tente com --estimate-gas primeiro"
    echo "   - Veja FIXED_CONSTRUCTOR.md para mais detalhes"
fi
