# Projeto COBOL - Processamento de Transações Bancárias

Projeto desenvolvido em COBOL no ambiente **TK5/MVS 3.8j**, utilizando **TN3270 Plus**.


---

## Lógica de Funcionamento

O programa lê clientes e transações bancárias, ordena os dados, compara os IDs, atualiza os saldos conforme créditos e débitos, registra erros quando houver inconsistências e gera os arquivos de saída com relatório, clientes atualizados e estatísticas finais.

---

## Regras do Programa

Cada cliente possui:

* ID do cliente
* Nome do cliente
* Saldo

Cada transação possui:

* ID do cliente
* ID da transação
* Tipo da transação
* Valor da transação

Tipos válidos:

* `C` = Crédito
* `D` = Débito

---

## Tratamento de Erros

O programa valida as seguintes situações:

### Cliente inexistente

Quando existe uma transação para um cliente que não está no arquivo de clientes.

```text
ERRO: CLIENTE NAO ENCONTRADO - ID 99999
```

### Tipo de transação inválido

Quando o tipo da transação não é `C` nem `D`.

```text
ERRO: TIPO DE TRANSACAO INVALIDO - ID 00123
```

### Valor zerado

Quando o valor da transação é igual a zero.

```text
ERRO: VALOR DE TRANSACAO INVALIDO - ID 00123
```

### Saldo insuficiente

Quando uma transação de débito possui valor maior que o saldo disponível.

```text
ERRO: SALDO INSUFICIENTE - ID 00123
```

Nesse caso, a transação não é aplicada e o saldo do cliente permanece o mesmo.

---

## Arquivos do Projeto

```text
PROJETO5.cbl        Programa principal COBOL
WRKP5.cpy           Variáveis de trabalho
ROTP5.cpy           Rotinas de processamento
COBP5.jcl           JCL de compilação
RUNP5.jcl           JCL de execução
CLIENTES.txt        Arquivo de entrada de clientes
TRANSAC.txt         Arquivo de entrada de transações
```

---

## Arquivos Gerados

```text
CLIENTES.ATU        Arquivo de clientes com saldo atualizado
RELAT.P5            Relatório com totais por cliente
ERROS.TXT           Arquivo com inconsistências encontradas
SYSOUT              Estatísticas finais da execução
```

---

## Layout dos Arquivos

### CLIENTES.TXT

Exemplo de registro:

```text
00123JOAO SILVA                    000010000
```

Tamanho total: **44 posições**

---

### TRANSAC.TXT

Exemplo de registro:

```text
0012300010C000000500
```

Tamanho total: **20 posições**

---

## Em Funcionamento no TK5



<img width="1200" height="675" alt="2026-06-12 12-52-39" src="https://github.com/user-attachments/assets/14cdee32-d76f-476a-9524-ba9da04b3624" />

---

## Clientes Atualizados



<img width="1371" height="403" alt="image" src="https://github.com/user-attachments/assets/81970df2-62d9-4bb3-8fa8-0ab6ae542957" />

---

## Relatório Gerado



<img width="1435" height="661" alt="image" src="https://github.com/user-attachments/assets/e2dc3fe0-600e-4700-bc59-af1db98b526c" />

---

## Arquivo de Erros



<img width="1530" height="409" alt="image" src="https://github.com/user-attachments/assets/5ce51b63-f83f-4911-a328-e51825f22540" />

---

## Output do RUNP5



<img width="1858" height="445" alt="image" src="https://github.com/user-attachments/assets/87351af5-3e93-4a8b-a79f-7d4fd0e60603" />


## Estatísticas da Execução

Ao final do processamento, o programa exibe no SYSOUT:

<img width="1060" height="247" alt="image" src="https://github.com/user-attachments/assets/e5b7bc8b-141f-4dae-be3d-75a64263d82a" />

---

## Objetivo do Projeto

Este projeto tem como objetivo praticar processamento de arquivos em COBOL no ambiente mainframe, utilizando leitura sequencial, ordenação via JCL, validação de dados, atualização de registros, geração de relatório e tratamento de erros.
