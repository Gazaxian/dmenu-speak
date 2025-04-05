#!/bin/bash

ARQUIVO="$HOME/Documentos/terminallang/anotacoes.txt"

[[ ! -f "$ARQUIVO" ]] && {
    echo "Arquivo de frases não encontrado."
    exit 1
}

DMENU_FONT="Monospace-12"
DMENU_FG="#ffffff"
DMENU_BG="#1e1e2e"
DMENU_SELFG="#1e1e2e"
DMENU_SELBG="#89b4fa"

termo=$(echo "" | dmenu -p "Digite a palavra-chave exata:" \
    -fn "$DMENU_FONT" \
    -nb "$DMENU_BG" -nf "$DMENU_FG" \
    -sb "$DMENU_SELBG" -sf "$DMENU_SELFG")

[[ -z "$termo" ]] && exit 0

termo_escapado=$(printf '%s\n' "$termo" | sed 's/[][\.*^$/]/\\&/g')

mapfile -t resultados < <(grep -i -E "(^|[^a-zA-Z])$termo_escapado([^a-zA-Z]|$)" "$ARQUIVO")

if [[ ${#resultados[@]} -eq 0 ]]; then
    notify-send "Nenhuma frase encontrada com: $termo"
    exit 0
fi

frase=$(printf '%s\n' "${resultados[@]}" | sort | dmenu -i -l 10 \
    -fn "$DMENU_FONT" \
    -nb "$DMENU_BG" -nf "$DMENU_FG" \
    -sb "$DMENU_SELBG" -sf "$DMENU_SELFG" \
    -p "Escolha a frase:")

[[ -z "$frase" ]] && exit 0

# Remove o texto entre parênteses e colchetes da frase para o espeak-ng
texto_para_ler=$(echo "$frase" | sed 's/[(].*//;s/\[.*\]//')

# Função para falar a frase
falar_frase() {
    sleep 1.2
    echo "$texto_para_ler" | espeak-ng -v en-us+f3 -s 130 -p 50
}

# Primeira leitura
falar_frase

# Exibe a janela com botão "Fechar" e "Repetir"
while true; do
    resposta=$(yad --title="Frase Completa" \
        --width=1350 --height=100 \
        --center \
        --text-info --fontname="Monospace 12" \
        --wrap=false \
        --no-markup \
        --button="Repetir!repeat":2 \
        --button="Fechar!exit":0 <<< "$frase")

    case $? in
        2) falar_frase ;;
        0) break ;;
    esac
done
