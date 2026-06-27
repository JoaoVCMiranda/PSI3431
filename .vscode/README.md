# .vscode/ — Ambiente de desenvolvimento MATLAB/Octave

Configurações VS Code para o projeto PSI3431. Nenhuma licença MATLAB necessária —
tudo roda com **Octave 11** (`octave --no-gui`).

---

## Arquivos

### `tasks.json` — tasks de execução

Atalhos via `Ctrl+Shift+B` (task padrão) ou `Ctrl+Shift+P → Tasks: Run Task`.

| Task | O que faz |
|------|-----------|
| `Octave: run file` (**padrão**) | Roda o arquivo `.m` **atualmente aberto** no editor |
| `Octave: run main.m` | Roda `main.m` na raiz do worktree |
| `Octave: run lab...` | Pede subpasta e script, roda `entregas/<dir>/<script>.m` |
| `Octave: run + save figs` | Igual ao `run file`, mas com flag para salvar figuras como PNG |
| `Play: Eddies_Twister.wav` | Reproduz o arquivo de áudio base via `aplay` |
| `Info: wav file` | Mostra metadados de um `.wav` (Fs, duração, canais) |

**Problem matcher Octave**: erros no formato `arquivo.m:linha: error: mensagem`
são parseados e apontados direto no editor (painel Problems + squiggles).

---

### `psi3431.code-snippets` — snippets MATLAB/Octave

Disponíveis em qualquer `.m` aberto no workspace. Ativar com prefixo + `Tab`
ou `Ctrl+Space`.

#### Boilerplate

| Prefixo | Gera |
|---------|------|
| `hdr` | Cabeçalho do script: `clear; clc; close all` + campos de aluno |
| `fun` | Definição de `function … end` com docstring |

#### Filtros adaptativos

| Prefixo | Gera |
|---------|------|
| `lms` | Loop LMS completo (ordem M, passo µ) |
| `nlms` | Loop NLMS com regularização ε |
| `rls` | Loop RLS com fator de esquecimento λ e inicialização de P |
| `wiener` | Solução ótima de Wiener offline (Rxx \ rxd) |

#### Análise espectral

| Prefixo | Gera |
|---------|------|
| `fftplt` | Calcula FFT e plota magnitude vs frequência |
| `spec` | Espectrograma (`spectrogram`) com janela configurável |
| `freqz` | Resposta em frequência magnitude + fase (`freqz`) |
| `psd` | Densidade espectral de potência (`pwelch`) |

#### Plots

| Prefixo | Gera |
|---------|------|
| `plt` | `plot` simples com xlabel/ylabel/title/grid |
| `fig` | `figure` com 3 subplots empilhados |
| `mse` | Curva de aprendizagem: `e²` em dB por iteração |
| `cmp` | 3 subplots: desejado / saída do filtro / erro |

#### Sinais e utilitários

| Prefixo | Gera |
|---------|------|
| `wav` | `audioread` + conversão para mono + eixo de tempo `t` |
| `sig` | Senoide + ruído gaussiano com Fs e duração configuráveis |
| `pr` | `fprintf('label: %g\n', var)` |
| `chk` | `assert(cond, 'mensagem')` |
| `sv` | `save` / `load` de variáveis em `.mat` |

---

### `extensions.json` — extensões recomendadas

O VS Code sugere instalar ao abrir o projeto. Instalar uma vez por máquina:

| Extensão | Para que serve |
|----------|---------------|
| `Gimly81.matlab` | Syntax highlight, indentação e snippets base para `.m` |
| `lieryan.matlab-interactive-terminal` | Envia linhas/seleções para terminal Octave interativo (`Shift+Enter`) |
| `mechatroner.rainbow-csv` | Visualização colorida de arquivos `.csv` de dados |

---

## Fluxo de trabalho recomendado (sessão de 2 h)

### Abertura
1. `code PSI3431.code-workspace` — abre com os dois painéis (control + worktree)
2. `Ctrl+Shift+P → Extensions: Show Recommended Extensions` → instalar se primeira vez

### Durante o desenvolvimento
- Abrir o `.m` do lab → escrever/completar com snippets → `Ctrl+Shift+B` para rodar
- Erros aparecem no painel **Problems** (`Ctrl+Shift+M`) com link para a linha exata
- Para explorar sinais: abrir terminal integrado → `octave --no-gui` → modo interativo

### Divisão de trabalho sugerida (3 pessoas, ~2 h)
| Pessoa | Responsabilidade |
|--------|-----------------|
| A | Implementação e teste do algoritmo (LMS/NLMS/RLS) |
| B | Geração de sinais, carregamento do `.wav`, preparação dos dados |
| C | Análise espectral (FFT, PSD, curvas de aprendizagem) e relatório |

---

## Referência rápida de atalhos

| Ação | Atalho |
|------|--------|
| Rodar arquivo atual | `Ctrl+Shift+B` |
| Listar todas as tasks | `Ctrl+Shift+P → Tasks: Run Task` |
| Ver erros do Octave | `Ctrl+Shift+M` (painel Problems) |
| Sugestão de snippet | `Ctrl+Space` em arquivo `.m` |
| Enviar seleção ao terminal Octave | `Shift+Enter` (extensão `lieryan`) |
