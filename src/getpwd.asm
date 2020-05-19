TITLE

DOSSEG
.MODEL small

; definizione segmento di stack
.STACK 100h

; definizione segmento dati
.DATA
	password db 32 dup(?), 0

; definizione segmento di codice
.CODE
start:
        MOV AX, @DATA       ; inizializzazione registro
        MOV DS, AX          ; di segmento DS
        LEA BX, password
        LEA DX, password    ; per fare un controllo che non si superino i caratteri massimi
        ADD DX, 31          ; 31 è il max numero di caratteri validi 32byte=31byte per l'uso + 1byte di fine '\0\'
        JMP read

read:
        MOV AH, 07h         ; lettura senza scrittura a video
        INT 21h

        CMP AL, 0Dh         ; controlla che se il carattere è '\n'
        JZ  end
        CMP BX, DX          ; controlla linite cifre
        JZ end

        MOV AH, 02h         ; scrittura "*" instead del carattere premuto
        MOV DL, 2Ah
        INT 21h

        MOV [BX], AL        ; memorizzo il carattere

        INC BX

        JMP read

end:
        MOV [BX], 0
        MOV AH, 4Ch         ; ritorno al sistema operativo
        INT 21h
        
; eventuali procedure

        END     start