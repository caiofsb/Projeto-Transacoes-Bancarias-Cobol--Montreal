       01  WKR-VARIAVEIS.

           05  WKR-FIM-PROC       PIC X(01) VALUE 'N'.
           05  WKR-FIM-CLI        PIC X(01) VALUE 'N'.
           05  WKR-FIM-TRX        PIC X(01) VALUE 'N'.

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

           05  WKR-CLIENTES-LIDOS PIC 9(06) VALUE ZEROS.
           05  WKR-TRANS-LIDAS    PIC 9(06) VALUE ZEROS.

           05  WKR-STATUS-CLI     PIC X(02) VALUE SPACES.
           05  WKR-STATUS-TRX     PIC X(02) VALUE SPACES.
           05  WKR-STATUS-ATU     PIC X(02) VALUE SPACES.
           05  WKR-STATUS-REL     PIC X(02) VALUE SPACES.
           05  WKR-STATUS-ERR     PIC X(02) VALUE SPACES.

           *> CONTROLE DE ERROS
           05  WKR-ERROS-TIPO
               PIC 9(06) VALUE ZEROS.

           05  WKR-ERROS-VALOR
               PIC 9(06) VALUE ZEROS.

           05  WKR-ERROS-SALDO
               PIC 9(06) VALUE ZEROS.

           05  WKR-ERROS-CLIENTE
               PIC 9(06) VALUE ZEROS.

           05  WKR-ULTIMO-ERRO
               PIC X(20) VALUE SPACES.

           *> CONTROLE FINANCEIRO GERAL
           05  WKR-TOT-CRED-GERAL
               PIC 9(12) VALUE ZEROS.

           05  WKR-TOT-DEB-GERAL
               PIC 9(12) VALUE ZEROS.

           05  WKR-SALDO-CRED-GERAL
               PIC 9(12) VALUE ZEROS.

           05  WKR-SALDO-DEB-GERAL
               PIC 9(12) VALUE ZEROS.

           05  WKR-TRANS-REJEITADAS
               PIC 9(06) VALUE ZEROS.


           *> CABECALHO DO RELATORIO
           05  REL-CAB-1          PIC X(132)
               VALUE
               'RELATORIO DE TRANSACOES BANCARIAS'.

           05  REL-TRACO          PIC X(132)
               VALUE
               '--------------------------------------------------'.

           05  REL-LINHA-BRANCO   PIC X(132)
               VALUE SPACES.


           *> CLIENTE
           05  REL-CLI.
               10  FILLER         PIC X(09)
                   VALUE 'CLIENTE: '.
               10  REL-CLI-ID     PIC 9(05)
                   VALUE ZEROS.
               10  FILLER         PIC X(118)
                   VALUE SPACES.


           *> CREDITOS
           05  REL-CRED.
               10  FILLER         PIC X(16)
                   VALUE 'TOTAL CREDITOS: '.
               10  REL-TOT-CRED   PIC 9(09)
                   VALUE ZEROS.
               10  FILLER         PIC X(107)
                   VALUE SPACES.


           *> DEBITOS
           05  REL-DEB.
               10  FILLER         PIC X(15)
                   VALUE 'TOTAL DEBITOS: '.
               10  REL-TOT-DEB    PIC 9(09)
                   VALUE ZEROS.
               10  FILLER         PIC X(108)
                   VALUE SPACES.


           *> ERRO CLIENTE
           05  ERR-CLI-NAO.
               10  FILLER         PIC X(34)
                   VALUE
                   'ERRO: CLIENTE NAO ENCONTRADO - ID '.
               10  ERR-ID-CLI     PIC 9(05)
                   VALUE ZEROS.
               10  FILLER         PIC X(41)
                   VALUE SPACES.


           *> ERRO TIPO
           05  ERR-TIPO.
               10  FILLER         PIC X(38)
                   VALUE
                   'ERRO: TIPO DE TRANSACAO INVALIDO - ID '.
               10  ERR-ID-TIPO    PIC 9(05)
                   VALUE ZEROS.
               10  FILLER         PIC X(37)
                   VALUE SPACES.


           *> ERRO VALOR
           05  ERR-VALOR.
               10  FILLER         PIC X(39)
                   VALUE
                   'ERRO: VALOR DE TRANSACAO INVALIDO - ID '.
               10  ERR-ID-VALOR   PIC 9(05)
                   VALUE ZEROS.
               10  FILLER         PIC X(36)
                   VALUE SPACES.


           *> ERRO SALDO
           05  ERR-SALDO.
               10  FILLER         PIC X(30)
                   VALUE
                   'ERRO: SALDO INSUFICIENTE - ID '.
               10  ERR-ID-SALDO   PIC 9(05)
                   VALUE ZEROS.
               10  FILLER         PIC X(45)
                   VALUE SPACES.