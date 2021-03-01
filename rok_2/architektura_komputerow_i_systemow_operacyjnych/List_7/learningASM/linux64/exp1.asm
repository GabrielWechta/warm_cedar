
       ORG  $8000
EKRA   EQU  *
    DTA D' >>> Programowanie '
    DTA D'procesora 6502 <<< '
       ORG  $600
DLIS   DTA  B($70),B($70),B($70)
       DTA  B($42),A(EKRA)
       DTA  B($41),A(DLIS)
       ORG  $58
       DTA  A(EKRA)
       ORG  $2C5
       DTA  B($02),B($6A)
       ORG  $22F
       DTA  B($22)
       DTA  A(DLIS)
