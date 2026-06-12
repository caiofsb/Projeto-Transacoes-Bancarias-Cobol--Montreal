           05  WKR-FIM-PROC       PIC X(01) VALUE 'N'.

           05  WKR-FIM-CLI        PIC X(01) VALUE 'N'.
               88  WKR-CLI-ACABOU VALUE 'S'.

           05  WKR-FIM-TRX        PIC X(01) VALUE 'N'.
               88  WKR-TRX-ACABOU VALUE 'S'.

           05  WKR-CHAVE-CLI      PIC X(05) VALUE SPACES.
           05  WKR-CHAVE-TRX      PIC X(05) VALUE SPACES.

           05  WKR-SALDO-ATUAL    PIC 9(09) VALUE ZEROS.
           05  WKR-TOT-CRED-CLI   PIC 9(09) VALUE ZEROS.
           05  WKR-TOT-DEB-CLI    PIC 9(09) VALUE ZEROS.

           05  WKR-CLIENTES-PROC  PIC 9(06) VALUE ZEROS.
           05  WKR-TRANS-PROC     PIC 9(06) VALUE ZEROS.
           05  WKR-CREDITOS-PROC  PIC 9(06) VALUE ZEROS.
           05  WKR-DEBITOS-PROC   PIC 9(06) VALUE ZEROS.
           05  WKR-ERROS          PIC 9(06) VALUE ZEROS.

           05  REL-CAB-1          PIC X(132)
               VALUE 'RELATORIO DE TRANSACOES BANCARIAS'.
           05  REL-TRACO          PIC X(132)
               VALUE '----------------------------------------'.
           05  REL-LINHA-BRANCO   PIC X(132) VALUE SPACES.

           05  REL-CLI.
               10  FILLER         PIC X(09) VALUE 'CLIENTE: '.
               10  REL-CLI-ID     PIC 9(05) VALUE ZEROS.
               10  FILLER         PIC X(118) VALUE SPACES.

           05  REL-CRED.
               10  FILLER         PIC X(16) VALUE 'TOTAL CREDITOS: '.
               10  REL-TOT-CRED   PIC 9(09) VALUE ZEROS.
               10  FILLER         PIC X(107) VALUE SPACES.

           05  REL-DEB.
               10  FILLER         PIC X(15) VALUE 'TOTAL DEBITOS: '.
               10  REL-TOT-DEB    PIC 9(09) VALUE ZEROS.
               10  FILLER         PIC X(108) VALUE SPACES.

           05  ERR-CLI-NAO.
               10  FILLER         PIC X(34)
                   VALUE 'ERRO: CLIENTE NAO ENCONTRADO - ID '.
               10  ERR-ID-CLI     PIC 9(05) VALUE ZEROS.
               10  FILLER         PIC X(41) VALUE SPACES.

           05  ERR-TIPO.
               10  FILLER         PIC X(38)
                   VALUE 'ERRO: TIPO DE TRANSACAO INVALIDO - ID '.
               10  ERR-ID-TIPO    PIC 9(05) VALUE ZEROS.
               10  FILLER         PIC X(37) VALUE SPACES.

           05  ERR-VALOR.
               10  FILLER         PIC X(39)
                   VALUE 'ERRO: VALOR DE TRANSACAO INVALIDO - ID '.
               10  ERR-ID-VALOR   PIC 9(05) VALUE ZEROS.
               10  FILLER         PIC X(36) VALUE SPACES.
           05  ERR-SALDO.
               10  FILLER         PIC X(30)
                   VALUE 'ERRO: SALDO INSUFICIENTE - ID '.
               10  ERR-ID-SALDO   PIC 9(05) VALUE ZEROS.
               10  FILLER         PIC X(45) VALUE SPACES.



