# K-Star-Patrol-ASMx86
Jogo K-Star Patrol desenvolvido em Assembly x86

Com certeza\! Baseado na descrição do projeto, nos arquivos fornecidos (código Assembly e relatório PDF) e no contexto da disciplina de Engenharia de Computação, aqui está uma sugestão de *README* para o repositório do GitHub.

Este *README* é estruturado para fornecer uma visão geral clara do projeto, sua implementação técnica e como executá-lo, focando na natureza acadêmica do trabalho.

-----

# 🚀 K-Star Patrol - Implementação em Assembly x86 (8086)

Este projeto consiste no desenvolvimento de um jogo baseado no clássico **K-Star Patrol** da CBS Software, implementado puramente em linguagem **Assembly** para a arquitetura **Intel 8086**.

O trabalho foi realizado como requisito da disciplina de Arquitetura de Computadores do curso de Engenharia de Computação da **Universidade de Caxias do Sul (UCS)**.

## ✨ Visão Geral do Projeto

O K-Star Patrol é um *shooter* de rolagem horizontal onde o jogador controla uma nave líder para proteger uma esquadrilha de 8 naves aliadas. O objetivo é destruir as naves alienígenas que se aproximam da direita antes que elas colidam com a patrulha.

O jogo foi adaptado com simplificações para atender aos requisitos e restrições de tempo da disciplina, incluindo:

  * **Modo Gráfico:** Utilização do modo de vídeo **320x200 (Modo 13H)**.
  * **Implementação Gráfica:** Desenho de pixels, naves e terreno utilizando **endereçamento indireto de memória** (`A000H`) em vez de interrupções de vídeo (`INT 10H`), visando maior eficiência.
  * **Estrutura:** Dividido em 3 **Setores** com terrenos distintos, tempo limite (60 segundos) e pontuação progressiva.
  * **Funcionalidades:** Menu inicial interativo, movimentação da nave líder, sistema de tiro, geração aleatória de naves alienígenas e sistema de pontuação com bônus e penalidades.

-----

## 💻 Como Executar o Jogo

O programa foi desenvolvido e testado nos ambientes de montagem **GUI Turbo Assembler (Windows)** e **Turbo Assembler (em Máquina Virtual)**.

### Pré-requisitos

1.  Um dos seguintes montadores:
      * **GUI Turbo Assembler** (Recomendado para Windows).
      * **Turbo Assembler (TASM)** e um emulador DOS (como o DOSBox) ou uma Máquina Virtual configurada para DOS.

### Passos de Execução

1.  **Montagem (Assembly):** Compile o arquivo fonte.
    ```bash
    TASM JogoOficial.asm
    ```
2.  **Ligação (Link):** Crie o executável.
    ```bash
    TLINK JogoOficial.OBJ
    ```
3.  **Execução:** Execute o programa no ambiente DOS.
    ```bash
    JogoOficial.EXE
    ```

-----

## 🕹️ Controles

| Ação | Tecla |
| :--- | :--- |
| **Menu:** Navegar para cima | Seta para Cima ($\uparrow$) |
| **Menu:** Navegar para baixo | Seta para Baixo ($\downarrow$) |
| **Menu:** Selecionar Opção | **ENTER** |
| **Jogo:** Mover Nave para cima | Seta para Cima ($\uparrow$) |
| **Jogo:** Mover Nave para baixo | Seta para Baixo ($\downarrow$) |
| **Jogo:** Disparar Tiro | **BARRA DE ESPAÇO** |

-----

## 🔧 Detalhes da Implementação Técnica

O código-fonte (`JogoOficial.asm`) é uma implementação robusta que busca otimizar a performance, uma característica crucial em Assembly.

### Estrutura do Código

O projeto segue a estrutura básica de programas Assembly para DOS:

  * `.MODEL SMALL`
  * `.STACK 100H`
  * `.DATA`: Contém todas as variáveis, *buffers* e constantes do jogo (pontuação, timers, *delays*, posições das naves, cores, etc.).
  * `.CODE`: Contém as rotinas principais e sub-rotinas (PROCedures) do jogo.

### Principais Rotinas (PROC)

O código evita duplicação de rotinas, utilizando procedimentos genéricos que são chamados para diferentes elementos do jogo (naves, tiro, terreno).

| Rotina | Descrição |
| :--- | :--- |
| `inicia_programa` | Inicializa o modo de vídeo (13H) e variáveis globais, como *timers* e *score*. |
| `loop_jogo` | O laço principal que gerencia o fluxo do jogo: verifica entradas, atualiza *status*, move elementos e verifica colisões. |
| `movimenta_elemento` | Rotina genérica de movimentação e desenho de naves e tiro, utilizando endereçamento indireto na memória de vídeo. |
| `desenha_terreno` | Desenha e realiza o *scroll* horizontal da superfície do planeta. |
| `interrompe_tempo` | Utiliza a interrupção `INT 15H, AH=86H` para suspender a execução por um intervalo de **microssegundos** (50ms). |
| `leitura_teclado` | Implementa a leitura de teclas **sem espera** (não bloqueante) utilizando `INT 16H, AH=01H` e `AH=00H`. |
| `toca_musica` | Rotinas de controle do *PC Speaker* e *Timer 8253* para a reprodução da música de fundo. |
| `gera_aleatorio` | Rotina para geração de números pseudo-aleatórios (detalhes do algoritmo [LCR ou similar] estão no relatório). |

### Otimização e Restrições

  * **Gerenciamento de Tempo:** A suspensão da execução (`INT 15H`) é usada para controlar a velocidade do jogo (50ms entre movimentos, conforme variável `DelayMovimentoL` no código).
  * **Impressão:** A impressão/ocultação de elementos gráficos (naves, tiro, terreno) é feita exclusivamente via **endereçamento indireto** ao segmento `A000H`, conforme a fórmula:
    $$\text{Endereço na Memória} = \text{A000H}:\big( (\text{Linha} \times 320) + \text{Coluna} \big)$$

-----

## 📚 Relatório do Projeto

O arquivo **`Relatório jogo K-star patrol final.pdf`** detalha toda a documentação do projeto, conforme as normas da revista **Scientia cum Industria**, incluindo:

  * **Seção 1 (Jogo):** Manual de operação e descrição de *gameplay*.
  * **Seção 2 (Solução):** Algoritmo principal (com fluxograma), detalhe da memória utilizada (código e dados) e descrição das principais rotinas, incluindo o uso de instruções **8086 não abordadas em aula** (ex: `IN`, `OUT` para controle de som).
  * **Seção 3 (Conclusões):** Discussão das dificuldades e aprendizados.

-----

## 👥 Autoria

**Desenvolvido por:**

  * Gabriel Tomazzoni Mazzarotto

**Universidade:** Universidade de Caxias do Sul (UCS)
**Curso:** Engenharia de Computação
**Ano:** 2024/2
