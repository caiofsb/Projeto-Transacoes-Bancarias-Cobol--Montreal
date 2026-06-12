       0100-INICIAR.

           MOVE 'N' TO WKR-FIM-PROC.
           MOVE 'N' TO WKR-FIM-CLI.
           MOVE 'N' TO WKR-FIM-TRX.

           MOVE SPACES TO WKR-CHAVE-CLI.
           MOVE SPACES TO WKR-CHAVE-TRX.

           MOVE ZEROS TO WKR-SALDO-ATUAL.

           MOVE ZEROS TO WKR-TOT-CRED-CLI.
           MOVE ZEROS TO WKR-TOT-DEB-CLI.

           MOVE ZEROS TO WKR-TOT-CRED-GERAL.
           MOVE ZEROS TO WKR-TOT-DEB-GERAL.

           MOVE ZEROS TO WKR-SALDO-CRED-GERAL.
           MOVE ZEROS TO WKR-SALDO-DEB-GERAL.

           MOVE ZEROS TO WKR-CLIENTES-PROC.
           MOVE ZEROS TO WKR-TRANS-PROC.

           MOVE ZEROS TO WKR-CREDITOS-PROC.
           MOVE ZEROS TO WKR-DEBITOS-PROC.

           MOVE ZEROS TO WKR-TRANS-REJEITADAS.
           MOVE ZEROS TO WKR-ERROS.

           MOVE ZEROS TO WKR-CLIENTES-LIDOS.
           MOVE ZEROS TO WKR-TRANS-LIDAS.

           MOVE ZEROS TO WKR-ERROS-TIPO.
           MOVE ZEROS TO WKR-ERROS-VALOR.
           MOVE ZEROS TO WKR-ERROS-SALDO.
           MOVE ZEROS TO WKR-ERROS-CLIENTE.

           MOVE SPACES TO WKR-ULTIMO-ERRO.


           OPEN INPUT ARQ-CLI.

           OPEN INPUT ARQ-TRX.

           OPEN OUTPUT ARQ-ATU.

           OPEN OUTPUT ARQ-REL.

           OPEN OUTPUT ARQ-ERR.


           WRITE REG-REL FROM REL-CAB-1.

           WRITE REG-REL FROM REL-TRACO.


           PERFORM 0300-LER-CLI.

           PERFORM 0400-LER-TRX.


       0200-PROCESSAR.

           IF WKR-FIM-CLI = 'S'

              IF WKR-FIM-TRX = 'S'

                 MOVE 'S' TO WKR-FIM-PROC

              ELSE

                 PERFORM 0700-TRANSACAO-SEM-CLI

              END-IF

           ELSE

              IF WKR-FIM-TRX = 'S'

                 PERFORM 0600-FINALIZA-CLIENTE

              ELSE

                 PERFORM 0230-COMPARAR

              END-IF

           END-IF.


       0230-COMPARAR.

           IF WKR-CHAVE-CLI = WKR-CHAVE-TRX

              PERFORM 0500-APLICA-TRANSACAO

           ELSE

              IF WKR-CHAVE-CLI < WKR-CHAVE-TRX

                 PERFORM 0600-FINALIZA-CLIENTE

              ELSE

                 PERFORM 0700-TRANSACAO-SEM-CLI

              END-IF

           END-IF.


       0300-LER-CLI.

           READ ARQ-CLI

              AT END

                 MOVE 'S' TO WKR-FIM-CLI

           END-READ.


           IF WKR-FIM-CLI NOT = 'S'

              ADD 1 TO WKR-CLIENTES-LIDOS

              MOVE CLI-ID
                TO WKR-CHAVE-CLI

              MOVE CLI-SALDO
                TO WKR-SALDO-ATUAL

              MOVE ZEROS
                TO WKR-TOT-CRED-CLI

              MOVE ZEROS
                TO WKR-TOT-DEB-CLI

              ADD 1
                TO WKR-CLIENTES-PROC

           END-IF.


       0400-LER-TRX.

           READ ARQ-TRX

              AT END

                 MOVE 'S' TO WKR-FIM-TRX

           END-READ.


           IF WKR-FIM-TRX NOT = 'S'

              ADD 1
                TO WKR-TRANS-LIDAS

              MOVE TRX-CLI-ID
                TO WKR-CHAVE-TRX

              ADD 1
                TO WKR-TRANS-PROC

           END-IF.


       0500-APLICA-TRANSACAO.

           PERFORM 0510-VALIDAR-TRANSACAO.


           IF WKR-ULTIMO-ERRO = SPACES

              IF TRX-TIPO = 'C'

                 PERFORM 0540-CREDITO

              ELSE

                 IF TRX-TIPO = 'D'

                    PERFORM 0545-DEBITO

                 END-IF

              END-IF

           END-IF.


           PERFORM 0400-LER-TRX.


       0510-VALIDAR-TRANSACAO.

           MOVE SPACES
             TO WKR-ULTIMO-ERRO.


           IF TRX-TIPO NOT = 'C'
              AND TRX-TIPO NOT = 'D'

              PERFORM 0830-ERRO-TIPO

           END-IF.


           IF TRX-VALOR = ZEROS

              PERFORM 0840-ERRO-VALOR

           END-IF.


       0540-CREDITO.

           ADD TRX-VALOR
             TO WKR-SALDO-ATUAL.

           ADD TRX-VALOR
             TO WKR-TOT-CRED-CLI.

           ADD TRX-VALOR
             TO WKR-TOT-CRED-GERAL.

           ADD TRX-VALOR
             TO WKR-SALDO-CRED-GERAL.

           ADD 1
             TO WKR-CREDITOS-PROC.


       0545-DEBITO.

           IF TRX-VALOR > WKR-SALDO-ATUAL

              PERFORM 0850-ERRO-SALDO

           ELSE

              SUBTRACT TRX-VALOR
                FROM WKR-SALDO-ATUAL

              ADD TRX-VALOR
                TO WKR-TOT-DEB-CLI

              ADD TRX-VALOR
                TO WKR-TOT-DEB-GERAL

              ADD TRX-VALOR
                TO WKR-SALDO-DEB-GERAL

              ADD 1
                TO WKR-DEBITOS-PROC

           END-IF.


       0600-FINALIZA-CLIENTE.

           MOVE CLI-ID
             TO ATU-ID.

           MOVE CLI-NOME
             TO ATU-NOME.

           MOVE WKR-SALDO-ATUAL
             TO ATU-SALDO.


           WRITE REG-CLI-ATU.


           MOVE CLI-ID
             TO REL-CLI-ID.

           WRITE REG-REL
             FROM REL-CLI.


           MOVE WKR-TOT-CRED-CLI
             TO REL-TOT-CRED.

           WRITE REG-REL
             FROM REL-CRED.


           MOVE WKR-TOT-DEB-CLI
             TO REL-TOT-DEB.

           WRITE REG-REL
             FROM REL-DEB.


           WRITE REG-REL
             FROM REL-LINHA-BRANCO.


           PERFORM 0300-LER-CLI.


       0700-TRANSACAO-SEM-CLI.

           MOVE TRX-CLI-ID
             TO ERR-ID-CLI.

           WRITE REG-ERR
             FROM ERR-CLI-NAO.


           ADD 1
             TO WKR-ERROS.

           ADD 1
             TO WKR-ERROS-CLIENTE.

           ADD 1
             TO WKR-TRANS-REJEITADAS.


           MOVE 'CLIENTE INEXISTENTE'
             TO WKR-ULTIMO-ERRO.


           PERFORM 0400-LER-TRX.


       0830-ERRO-TIPO.

           MOVE TRX-CLI-ID
             TO ERR-ID-TIPO.


           WRITE REG-ERR
             FROM ERR-TIPO.


           ADD 1
             TO WKR-ERROS.

           ADD 1
             TO WKR-ERROS-TIPO.

           ADD 1
             TO WKR-TRANS-REJEITADAS.


           MOVE 'TIPO INVALIDO'
             TO WKR-ULTIMO-ERRO.


       0840-ERRO-VALOR.

           MOVE TRX-CLI-ID
             TO ERR-ID-VALOR.


           WRITE REG-ERR
             FROM ERR-VALOR.


           ADD 1
             TO WKR-ERROS.

           ADD 1
             TO WKR-ERROS-VALOR.

           ADD 1
             TO WKR-TRANS-REJEITADAS.


           MOVE 'VALOR INVALIDO'
             TO WKR-ULTIMO-ERRO.


       0850-ERRO-SALDO.

           MOVE TRX-CLI-ID
             TO ERR-ID-SALDO.


           WRITE REG-ERR
             FROM ERR-SALDO.


           ADD 1
             TO WKR-ERROS.

           ADD 1
             TO WKR-ERROS-SALDO.

           ADD 1
             TO WKR-TRANS-REJEITADAS.


           MOVE 'SALDO INSUFICIENTE'
             TO WKR-ULTIMO-ERRO.


       0900-FINALIZAR.

           WRITE REG-REL
             FROM REL-TRACO.


           DISPLAY '****************************************'.

           DISPLAY 'ESTATISTICAS DE PROCESSAMENTO'.

           DISPLAY '****************************************'.


           DISPLAY 'CLIENTES PROCESSADOS.....: '
                   WKR-CLIENTES-PROC.

           DISPLAY 'CLIENTES LIDOS...........: '
                   WKR-CLIENTES-LIDOS.


           DISPLAY 'TRANSACOES PROCESSADAS...: '
                   WKR-TRANS-PROC.

           DISPLAY 'TRANSACOES LIDAS.........: '
                   WKR-TRANS-LIDAS.


           DISPLAY 'CREDITOS PROCESSADOS.....: '
                   WKR-CREDITOS-PROC.

           DISPLAY 'DEBITOS PROCESSADOS......: '
                   WKR-DEBITOS-PROC.


           DISPLAY 'ERROS ENCONTRADOS........: '
                   WKR-ERROS.


           DISPLAY 'ERROS DE TIPO............: '
                   WKR-ERROS-TIPO.

           DISPLAY 'ERROS DE VALOR...........: '
                   WKR-ERROS-VALOR.

           DISPLAY 'ERROS DE SALDO...........: '
                   WKR-ERROS-SALDO.

           DISPLAY 'ERROS DE CLIENTE.........: '
                   WKR-ERROS-CLIENTE.


           DISPLAY 'TRANSACOES REJEITADAS....: '
                   WKR-TRANS-REJEITADAS.


           DISPLAY 'TOTAL CREDITOS...........: '
                   WKR-TOT-CRED-GERAL.

           DISPLAY 'TOTAL DEBITOS............: '
                   WKR-TOT-DEB-GERAL.


           DISPLAY 'VALOR CREDITOS...........: '
                   WKR-SALDO-CRED-GERAL.

           DISPLAY 'VALOR DEBITOS............: '
                   WKR-SALDO-DEB-GERAL.


           DISPLAY 'FIM DO PROCESSAMENTO'.


           CLOSE ARQ-CLI.

           CLOSE ARQ-TRX.

           CLOSE ARQ-ATU.

           CLOSE ARQ-REL.

           CLOSE ARQ-ERR.