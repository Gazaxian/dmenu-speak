# dmenu-speak

Um script em Bash que permite buscar frases em inglês por palavra-chave usando `dmenu`, ouvir a frase com `espeak-ng` e visualizar a frase completa com uma interface gráfica usando `yad`.

Ideal para estudantes de inglês que utilizam o sistema Terminallang para estudar com frases traduzidas e organizadas.

## Funcionalidades

- Busca de frases por palavra-chave exata (com suporte a acentuação).
- Interface rápida e minimalista com `dmenu`.
- Leitura da frase com `espeak-ng` (voz feminina, inglês dos EUA).
- Exibição da frase completa com opção de repetir ou fechar (`yad`).
- Compatível com frases no formato do Terminallang:  
  `Frase em inglês (pronúncia) [tradução]`.

## Requisitos

- `dmenu`
- `espeak-ng`
- `yad`

## Como usar

1. Certifique-se de ter o arquivo `anotacoes.txt` com frases no formato esperado.
2. Torne o script executável:

   ```bash
   chmod +x dmenu-speak.sh
   ```

3. Execute o script:

   ```bash
   ./dmenu-speak.sh
   ```

4. Digite a palavra-chave desejada.
5. Selecione uma frase.
6. A frase será lida em voz alta e exibida com opções de interação.

## Exemplo de frase válida

```
She is reading a book (shi iz rí-din a bûk) [Ela está lendo um livro]
```

## Licença

Este projeto é de uso pessoal.
