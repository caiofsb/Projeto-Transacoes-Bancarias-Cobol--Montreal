       0100-INICIAR.

           MOVE 'N' TO WKR-FIM-PROC.
           MOVE 'N' TO WKR-FIM-CLI.
           MOVE 'N' TO WKR-FIM-TRX.

           MOVE SPACES TO WKR-CHAVE-CLI.
           MOVE SPACES TO WKR-CHAVE-TRX.

           MOVE ZEROS TO WKR-SALDO-ATUAL.
           MOVE ZEROS TO WKR-TOT-CRED-CLI.
           MOVE ZEROS TO WKR-TOT-DEB-CLI.

           MOVE ZEROS TO WKR-CLIENTES-PROC.
           MOVE ZEROS TO WKR-TRANS-PROC.
           MOVE ZEROS TO WKR-CREDITOS-PROC.
           MOVE ZEROS TO WKR-DEBITOS-PROC.
           MOVE ZEROS TO WKR-ERROS.

           MOVE ZEROS TO WKR-CLIENTES-LIDOS.
           MOVE ZEROS TO WKR-TRANS-LIDAS.

           MOVE SPACES TO WKR-STATUS-CLI.
           MOVE SPACES TO WKR-STATUS-TRX.
           MOVE SPACES TO WKR-STATUS-ATU.
           MOVE SPACES TO WKR-STATUS-REL.
           MOVE SPACES TO WKR-STATUS-ERR.


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

           IF WKR-CLI-ACABOU

              PERFORM 0210-CLIENTE-ACABOU

           ELSE

              IF WKR-TRX-ACABOU

                 PERFORM 0600-FINALIZA-CLIENTE

              ELSE

                 PERFORM 0230-COMPARAR.


       0210-CLIENTE-ACABOU.

           IF WKR-TRX-ACABOU

              MOVE 'S' TO WKR-FIM-PROC

           ELSE

              PERFORM 0700-TRANSACAO-SEM-CLI.


       0230-COMPARAR.

           IF WKR-CHAVE-CLI IS EQUAL TO WKR-CHAVE-TRX

              PERFORM 0500-APLICA-TRANSACAO

           ELSE

              IF WKR-CHAVE-CLI IS LESS THAN WKR-CHAVE-TRX

                 PERFORM 0600-FINALIZA-CLIENTE

              ELSE

                 PERFORM 0700-TRANSACAO-SEM-CLI.


       0300-LER-CLI.

           READ ARQ-CLI

              AT END

                 MOVE 'S' TO WKR-FIM-CLI

           END-READ.


           IF WKR-FIM-CLI IS NOT EQUAL TO 'S'

              ADD 1 TO WKR-CLIENTES-LIDOS

              MOVE CLI-ID TO WKR-CHAVE-CLI

              MOVE CLI-SALDO TO WKR-SALDO-ATUAL

              MOVE ZEROS TO WKR-TOT-CRED-CLI

              MOVE ZEROS TO WKR-TOT-DEB-CLI

              ADD 1 TO WKR-CLIENTES-PROC.


       0400-LER-TRX.

           READ ARQ-TRX

              AT END

                 MOVE 'S' TO WKR-FIM-TRX

           END-READ.


           IF WKR-FIM-TRX IS NOT EQUAL TO 'S'

              ADD 1 TO WKR-TRANS-LIDAS

              MOVE TRX-CLI-ID TO WKR-CHAVE-TRX

              ADD 1 TO WKR-TRANS-PROC.


       0500-APLICA-TRANSACAO.

           IF TRX-TIPO IS EQUAL TO 'C'

              PERFORM 0540-CREDITO

           ELSE

              IF TRX-TIPO IS EQUAL TO 'D'

                 PERFORM 0545-DEBITO

              ELSE

                 PERFORM 0830-ERRO-TIPO.


           PERFORM 0400-LER-TRX.


       0540-CREDITO.

           IF TRX-VALOR IS EQUAL TO ZEROS

              PERFORM 0840-ERRO-VALOR

           ELSE

              ADD TRX-VALOR TO WKR-SALDO-ATUAL

              ADD TRX-VALOR TO WKR-TOT-CRED-CLI

              ADD 1 TO WKR-CREDITOS-PROC.


       0545-DEBITO.

           IF TRX-VALOR IS EQUAL TO ZEROS

              PERFORM 0840-ERRO-VALOR

           ELSE

              IF TRX-VALOR IS GREATER THAN WKR-SALDO-ATUAL

                 PERFORM 0850-ERRO-SALDO

              ELSE

                 SUBTRACT TRX-VALOR FROM WKR-SALDO-ATUAL

                 ADD TRX-VALOR TO WKR-TOT-DEB-CLI

                 ADD 1 TO WKR-DEBITOS-PROC.


       0600-FINALIZA-CLIENTE.

           MOVE CLI-ID TO ATU-ID.

           MOVE CLI-NOME TO ATU-NOME.

           MOVE WKR-SALDO-ATUAL TO ATU-SALDO.

           WRITE REG-CLI-ATU.


           MOVE CLI-ID TO REL-CLI-ID.

           WRITE REG-REL FROM REL-CLI.


           DISPLAY 'CLIENTE: ' CLI-ID.


           MOVE WKR-TOT-CRED-CLI TO REL-TOT-CRED.

           WRITE REG-REL FROM REL-CRED.

           DISPLAY 'TOTAL CREDITOS: ' WKR-TOT-CRED-CLI.


           MOVE WKR-TOT-DEB-CLI TO REL-TOT-DEB.

           WRITE REG-REL FROM REL-DEB.

           DISPLAY 'TOTAL DEBITOS: ' WKR-TOT-DEB-CLI.


           WRITE REG-REL FROM REL-LINHA-BRANCO.


           PERFORM 0300-LER-CLI.


       0700-TRANSACAO-SEM-CLI.

           MOVE TRX-CLI-ID TO ERR-ID-CLI.

           WRITE REG-ERR FROM ERR-CLI-NAO.

           ADD 1 TO WKR-ERROS.

           PERFORM 0400-LER-TRX.


       0830-ERRO-TIPO.

           MOVE TRX-CLI-ID TO ERR-ID-TIPO.

           WRITE REG-ERR FROM ERR-TIPO.

           ADD 1 TO WKR-ERROS.


       0840-ERRO-VALOR.

           MOVE TRX-CLI-ID TO ERR-ID-VALOR.

           WRITE REG-ERR FROM ERR-VALOR.

           ADD 1 TO WKR-ERROS.


       0850-ERRO-SALDO.

           MOVE TRX-CLI-ID TO ERR-ID-SALDO.

           WRITE REG-ERR FROM ERR-SALDO.

           ADD 1 TO WKR-ERROS.


       0900-FINALIZAR.

           WRITE REG-REL FROM REL-TRACO.


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

           DISPLAY 'FIM DO PROCESSAMENTO'.


           CLOSE ARQ-CLI.

           CLOSE ARQ-TRX.

           CLOSE ARQ-ATU.

           CLOSE ARQ-REL.

           CLOSE ARQ-ERR.