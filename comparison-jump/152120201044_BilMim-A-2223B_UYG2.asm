; @author	152120201044 Sude Cakmak
; @date		2023.05.09
; @brief	152120201044_BilMim-A-2223B_UYG2 (The data size falling into each interval is calculated over the predefined start and end values.)

  
lea SI, dataTrain                            ; Select data

countChar:
    lodsb                                    ; Load to al  
    cmp al, 0
    jz end                                   ; If al==0 jump to end
              
              
; Count lower
; Lowercase chars range in ascii -> [97, 122]
    cmp al, 97
    jb notLower                              ; If al<61h jump 
    cmp al, 122
    ja notLower                              ; If al>7Ah jump
    inc result_C                             ; Inc char count
    jmp notUpper  
                                             ; char is lowercase skip upper control
notLower:
     
; Count upper
; Uppercase chars range in ascii -> [65, 90]
    cmp al, 65
    jb notUpper                              ; If al<41h jump 
    cmp al, 90                               
    ja notUpper                              ; If al>5Ah jump
    inc result_C                             ; Inc char count   

notUpper:


;CountUnsigned
    mov  cx, 2                               ; loop count 
    mov  DI, 0                               ; indexing            
    
CountUnsignedChar:       

    cmp  al, interval_U_s[DI]
    jb   NotUnsigned                         ; If al<interval_U_s[bx], 'jb' -> unsigned 
    cmp  al, interval_U_f[DI]
    ja   NotUnsigned                         ; If al<interval_U_f[bx], 'ja' -> unsigned
    inc  result_U[DI]                        ; Inc unsigned count.
                    
NotUnsigned:                                            
    inc  DI 
    loop CountUnsignedChar  
 
    
       
;CountSigned       
    mov  cx, 4                               ; loop count
    mov  bx, 0                               ; indexing
                
countSignedChar:      
    cmp  al, interval_S_s[bx]
    jl   NotSigned                           ; If al<interval_S_s[bx], 'jl' -> signed
    cmp  al, interval_S_f[bx]
    jg   NotSigned                           ; If al<interval_S_f[bx], 'jg' -> signed
    inc  result_S[bx]                        ; Inc signed count.
                          
NotSigned:  
    inc  bx 
    loop countSignedChar    
    
    
    inc  result_Total                        ; Inc total
    jmp  countChar                           
    
end:                

hlt ; end of the code part

;pre-defined variables (data)
interval_U_s db   20, 115  				; Unsigned interval  start values
interval_U_f db   75, 200  				; Unsigned interval finish values

interval_S_s db -125, -40,   5,  60		; Signed interval  start values
interval_S_f db  -50, -10,  40, 105		; Signed interval finish values

result_Total dw 0						; byte-data count
result_C     db 0						; matched byte-data counts for given     char constraints, respectively.       
result_U     db 0,0						; matched byte-data counts for given unsigned constraints, respectively.
result_S     db 0,0,0,0					; matched byte-data counts for given   signed constraints, respectively.       

dataTrain db 'Scuderia F.', 16, 'LEC', 0AAh, 55, 'SAI', 0FFh, -100, 0, 0AAh
dataTest  db 009h,	08Fh,	063h,	055h,	01Dh,	0DFh,	010h,	0F5h,	0ECh,	0CCh,	0EFh,	045h,	0EBh,	032h,	020h,	0DBh,	0BCh,	0F4h,	025h,	03h,	0EAh,	05Dh,	062h,	022h,	064h,	038h,	058h,	04Bh,	0Ch,	04Fh,	0A0h,	0EEh,	065h,	05Ch,	030h,	0EFh,	0E8h,	051h,	069h,	0C7h,	08Fh,	060h,	02Ch,	010h,	078h,	07Fh,	0EBh,	0EDh,	06Ah,	060h,	07h,	07Bh,	0C7h,	05Dh,	0D3h,	0B6h,	056h,	082h,	05Fh,	052h,	065h,	07Bh,	02Bh,	0D4h,	0FFh,	09Ah,	05Dh,	0B0h,	06Dh,	0Ch,	07Ch,	06Fh,	049h,	0E0h,	014h,	016h,	023h,	0CAh,	0A1h,	0C3h,	065h,	084h,	06Bh,	03Ah,	051h,	087h,	012h,	0EFh,	096h,	039h,	0E0h,	026h,	09h,	03h,	07Eh,	0DBh,	0A1h,	0Bh,	0CAh,	0ECh
db 0D6h,	0AAh,	033h,	0Bh,	0A0h,	090h,	0D2h,	057h,	0EBh,	047h,	02Ah,	04Fh,	0DCh,	0F4h,	0EFh,	0E1h,	057h,	0B3h,	0A2h,	017h,	08h,	01Dh,	0A9h,	05Ch,	011h,	0Eh,	019h,	081h,	02Ch,	07Fh,	02Eh,	04Dh,	01Ah,	0B1h,	0D2h,	057h,	09h,	0C7h,	0EBh,	0F4h,	0DEh,	0F4h,	0Eh,	0E2h,	07Dh,	078h,	07Fh,	0C9h,	059h,	04h,	09h,	0E2h,	098h,	0EBh,	0ECh,	09Ch,	02h,	0ECh,	0A1h,	05h,	030h,	09Eh,	0E0h,	028h,	048h,	067h,	0C9h,	08Ah,	05Eh,	080h,	0CAh,	040h,	05Ch,	05Dh,	0CEh,	055h,	03Dh,	05Dh,	085h,	0B0h,	0A0h,	0E5h,	0C4h,	0CBh,	0Eh,	0E8h,	011h,	078h,	043h,	012h,	05Ch,	03Dh,	0CDh,	055h,	063h,	05Ch,	0E6h,	04h,	042h,	0CBh
db 0FDh,	0E2h,	012h,	0CCh,	056h,	021h,	074h,	081h,	073h,	0E9h,	0DEh,	05h,	0CBh,	0EAh,	0EFh,	0F4h,	07Fh,	0D8h,	0Fh,	010h,	08Fh,	067h,	0Eh,	0A3h,	039h,	0F2h,	09Dh,	0BEh,	080h,	0Fh,	0F8h,	047h,	0E8h,	039h,	0F3h,	0DEh,	0CBh,	08Ah,	0Eh,	0CDh,	0CDh,	087h,	0Fh,	0B5h,	0A7h,	09h,	0DFh,	054h,	012h,	07h,	0DDh,	014h,	04Ah,	0DCh,	09Fh,	0CDh,	05Ch,	0CBh,	0D0h,	052h,	03Ch,	053h,	08h,	017h,	07Bh,	065h,	089h,	023h,	024h,	010h,	0Dh,	0Ch,	016h,	060h,	0F0h,	031h,	010h,	0E8h,	01h,	051h,	0E5h,	064h,	0Ah,	0F2h,	0CAh,	07Eh,	0A5h,	05Ch,	07h,	0DAh,	0E8h,	027h,	016h,	041h,	0EFh,	0E6h,	063h,	07Ch,	01Fh,	0A8h  
db 068h,	08Fh,	0CAh,	045h,	011h,	053h,	037h,	0E5h,	02Ch,	011h,	0E8h,	0E0h,	01Fh,	012h,	07h,	076h,	012h,	01h,	0Ch,	057h,	0CAh,	07Fh,	064h,	0BBh,	0DFh,	065h,	0A7h,	08h,	019h,	0F9h,	0E9h,	090h,	033h,	0C0h,	0E3h,	0Ah,	0E3h,	017h,	05Ch,	0DDh,	0C5h,	01Fh,	0E6h,	0DFh,	031h,	06Bh,	081h,	0E4h,	049h,	0EEh,	0CBh,	0ECh,	074h,	0C6h,	09Dh,	0ECh,	0Dh,	042h,	0D5h,	010h,	063h,	0D8h,	0Fh,	03h,	0BAh,	057h,	0FEh,	0Ah,	0E5h,	0CFh,	07h,	070h,	0DBh,	08Eh,	080h,	0CCh,	013h,	061h,	08Dh,	01Dh,	097h,	0Dh,	0E2h,	0B1h,	0Bh,	0C8h,	043h,	062h,	0EAh,	06Ch,	091h,	0E6h,	0DBh,	02Fh,	065h,	06h,	0E8h,	064h,	079h,	053h 
db 00Ch,	032h,	0Dh,	078h,	0CCh,	069h,	04h,	0CEh,	0CCh,	050h,	0F1h,	05Fh,	0DDh,	010h,	078h,	0F1h,	04h,	0Fh,	0B1h,	0CCh,	0CBh,	05Dh,	0CCh,	054h,	0FAh,	0ECh,	05h,	08Ch,	010h,	0Ah,	081h,	0AEh,	05Dh,	066h,	063h,	07Ch,	0DBh,	0A7h,	02Dh,	0EFh,	07Eh,	0Fh,	06h,	0DAh,	0BCh,	071h,	066h,	0F1h,	09h,	0E8h,	0EBh,	07h,	0E0h,	0E0h,	0E6h,	07h,	0E6h,	050h,	012h,	0D4h,	09h,	05Eh,	0CCh,	012h,	0EDh,	043h,	024h,	0Dh,	0Fh,	0E2h,	039h,	042h,	02Ch,	02Ah,	0Ah,	01Bh,	010h,	0E6h,	075h,	0CAh,	02Bh,	09h,	08h,	0E4h,	010h,	066h,	06h,	0B3h,	0D7h,	053h,	054h,	045h,	0E5h,	0Ah,	05Ch,	059h,	0E4h,	052h,	08Ch,	0EDh
db 0DFh,	0EBh,	017h,	012h,	034h,	0E1h,	0BAh,	02Dh,	0CAh,	03Eh,	0F6h,	0F8h,	071h,	0FBh,	02Eh,	06h,	0D9h,	0EAh,	0CAh,	0EBh,	0BBh,	079h,	0Ch,	0AFh,	0FBh,	02Bh,	0E6h,	0B1h,	0FBh,	041h,	011h,	0EEh,	010h,	012h,	05Ch,	0EAh,	047h,   000h,   078h,	0CCh,	069h,	04h,	0CEh,	0CCh,	050h,	0F1h,	05Fh,	0DDh,	010h,	078h,	0F1h,	04h,	0Fh,	0B1h,	0CCh,	0CBh,	05Dh,	0CCh,	054h,	0FAh,	0ECh,	05h,	08Ch,	010h,	0Ah,	081h,   078h,	0CCh,	069h,	04h,	0CEh,	0CCh,	050h,	0F1h,	05Fh,	0DDh,	010h,	078h,	0F1h,	04h,	0Fh,	0B1h,	0CCh,	0CBh,	05Dh,	0CCh,	054h,	0FAh,	0ECh,	05h,	08Ch,	010h,	0Ah,	081h,   078h,	0CCh,	069h,	04h,	0CEh,	0CCh
