; @author	152120201044 Sude Cakmak
; @date		2023.05.23
; @brief	BilMim-A-2223B_UYG3    (arranges code blocks as desired)

        mov     si, offset inputCodded
        mov     di, offset outputWOCode                        
        call    extractCleanText   
               
        lea     si, inputCodded 
        lea     di, outputGenerated                        
        call    extractCoddedText

        ;Bonus Part
        ;mov si, offset inputBonus ; if you have completed the bonus assignment as well, simply uncomment this block and submit your assignment accordingly.
        ;mov di, offset outputBonus                        
        ;call extractCoddedText   
         
        ;screenshot your output screen and submit it in a .zip file with your code.
        mov ah,9 ; + int 21h -> ; output of a string at DS:DX. String must be terminated by '$'. 
        mov dx, offset textStudent
        int 21h
        mov dx, offset textWOCode
        int 21h
        mov dx, offset outputWOCode
        int 21h
        mov dx, offset textOutput
        int 21h
        mov dx, offset outputGenerated
        int 21h
        mov dx, offset textOutputBonus
        int 21h
        mov dx, offset outputBonus
        int 21h                 
                
finish: hlt

proc extractCleanText
    
    LoopClean:
        lodsb                          ; Load [SI] into AL
        cmp  al,'$' 
        je   endClean                  ; If al=='$' jump to endClean
               
        cmp  al, '<'                   ; If al=='<' code block starts 
        jne  notBlockStart        
        add  si, 7                     ; check if block ends
        lodsb                         
        cmp  al, '>'                   ; If al=='>' code block ends
        jne  notBlockEnd      
		jmp  LoopClean               
	
	notBlockStart:
	    dec  si                       
	    movsb                          ; Move [SI] to [DI].
	    jmp  LoopClean             
	
	notBlockEnd:
	    sub  si, 9                     ; Substract 9 for code block
	    movsb                          ; Move [SI] to [DI].
	    jmp  LoopClean               
	
	endClean:
        ret


proc extractCoddedText
        mov bx, 0                      ; indexing
    
    LoopExtract:
        lodsb                          ; Load [SI] into AL
        cmp al,'$'
        je  EndExtract                 ; If al=='$' end
        
        dec si                        
        mov [TEMP], si                 ; SI going to change, copy SI     
   
         
    ; End of   
    endofc:
        lea di, codeEnd             
        mov cx, 9                      ; code blocks is 9 char
        rep cmpsb                      ; Repeat compare [SI]==[DI].     
        jne Notendofc
        mov [ENDOF], 1                 ; If [SI]==[DI] set ENDOF 1
        jmp end                     
    
    Notendofc:
        mov si, [TEMP]                 ; Set SI to beginning of the block 
        mov [ENDOF], 0                 ; If [SI]!=[DI] set ENDOF 0
        
        
         
    ; Upper     
        cmp [UPPER], 1                 ; UPPER variable is already set
        je  SkipUpper                  ; If UPPER==1 
    
    caseUpp:
        lea di, codeCaseU           
        mov cx, 9                   
        rep cmpsb                      ; Repeat compare [SI]==[DI].
        jne NotCaseUpper
        mov [UPPER], 1                 ; If [SI]==[DI] set UPPER 1
        jmp saveAsUpper            
    NotCaseUpper:
        mov si, [TEMP]                 ; Set SI to beginning of the block
        mov [UPPER], 0                 ; If [SI]!=[DI] set UPPER 0    
    SkipUpper:
        
        
     
     ; Lower   
        cmp [LOWER], 1                 ; LOWER variable is already set
        je  SkipLower                  ; If LOWER==1 
             
    caseLow:
        lea di, codeCaseL              
        mov cx, 9                      
        rep cmpsb                      ; Repeat compare [SI]==[DI].
        jne NotCaseLower
        mov [LOWER], 1                 ; If [SI]==[DI] set LOWER 1
        jmp SaveAsLower               
    NotCaseLower:
        mov si, [TEMP]                 ; Set SI to beginning of the block
        mov [LOWER], 0                 ; If [SI]!=[DI] set LOWER 0
    SkipLower:
              
        
        
    ; Flu         
        cmp [FLU], 1                   ; FLUCASE variable is already set
        je SaveAsFlu                   ; If FLU==1 
    
    caseFlu:
        lea di, codeCaseFLU           
        mov cx, 9                   
        rep cmpsb                      ; Repeat compare [SI]==[DI].
        jne NotCaseFlu
        mov [FLU], 1                   ; If [SI]==[DI], set FLU 1
        jmp SaveAsFlu          
    NotCaseFlu:
        mov si, [TEMP]                 ; Set SI to the beginning of the block
        mov [FLU], 0                   ; If [SI]!=[DI], set FLU 0
        jmp ControlNumber
            
            
    SaveAsFlu:                           
        cmp al, 'a'
        jb notLower                             
        cmp al, 'z'
        ja notLower
        inc FIRSTCHAR                    ; is letter
        jmp isFirst 
    notLower:                                  
        cmp al, 'A'
        jb saveAsNormal                              
        cmp al, 'Z'                               
        ja saveAsNormal
        inc FIRSTCHAR                    ; is letter
    
    isFirst:                             ; Conrols if it is a first letter
        cmp [FIRSTCHAR], 1               ; If FIRSTCHAR==1
        je SaveAsUpper                   ; Save Upper
                  
        jmp SaveAsLower                  ; Else save lower

             
    ControlNumber:                       ; Controls if it is a number
        cmp al, '0'                 
        jb NotNumber             
          
    NotNumber:
        cmp al, '9'                 
        jb saveAsNormal             
       
           
        cmp [UPPER], 1          
        je SaveAsUpper                   ; If UPPER==1 SaveAsUpper
        
        cmp [LOWER], 1         
        je SaveAsLower                   ; If LOWER==1 SaveAsLower 
    
     
     
    SaveAsNormal:                  
        lodsb                               
        lea di, [outputGenerated + bx]   ; Set DI
        stosb
        inc bx                           ; indexing
        jmp LoopExtract
    
          
    SaveAsUpper:            
        lodsb                       
        and al, 11011111b                ; save as upper
        lea di, [outputGenerated + bx]   ; Set DI
        stosb                          
        inc bx                           ; indexing
        jmp LoopExtract         
    
       
    SaveAsLower:
        lodsb                      
        or al, 00100000b                 ; save as lower
        lea di, [outputGenerated + bx]   ; Set DI
        stosb                            
        inc bx                           ; indexing
        jmp LoopExtract         
    
      end:
        mov [UPPER], 0
        mov [LOWER], 0
        mov [ENDOF], 0 
        mov [FLU],   0
        jmp LoopExtract
       
    
    EndExtract:    
        ret
    
proc ifNecessary
        ;TODO
        ret            

codeLength      dw 9
codeCaseU       db '<caseUpp>' 
codeCaseL       db '<caseLow>' 
codeCaseFLU     db '<caseFLU>'
codeCaseLgl     db '<caseLgl>'
codeCaseTrC     db '<caseTrC>'
codeEnd         db '</endofc>'

;for this Bonus part, pre-defined, length=12 is free to use
charsUnwanted   db '£%!&?/\|{}[]'
charFindTRkeyb  db 'çÇğĞıİöÖşŞüÜ' 
charReplTRAscii db 87h, 80h,0a7h,0a6h,8dh,98h,94h,99h,9fh,9eh,9ah,81h
 
textStudent     db '152120201044 Sude Cakmak','$'                     ;text + endofchar
textWOCode      db 13,10,13,10, 'A. Output w/o Codes:',13,10, '$'     ;newline (cursor) + text + newline (cursor) + endofchar
textOutput      db 13,10,13,10, 'B. Output Generated:',13,10, '$'
textOutputBONUS db 13,10,13,10, 'B. Output Generated (bonus part):',13,10, '$'

inputCodded     db '<caseUpp>bIlGiSayAr muHENDISligI (1521)</endofc> bolumu <caseFLU>152116026 bIlGiSayAr miMAriSi (A/B) 22/23 bAHar</endofc> Hafta 13, Uygu<caseLow>lamali DeRS Haftasi 4, </endofc>UYG3: Str<caseLow>ING islemLERi</endofc>!','$'
inputBonus		db 'i<caseTrC>şlenmemiş bu değişken içerisinde değiştirilen Türkçe karakter sayısı X </endofc>ol<caseLgl>s%!?{u&}n, !i%[/s?]t&en!m£e{!yen ?!%/]&ka|!ra&kt}e£r! s&a?y/[!!%i|si i!s&e£/] %?!Y& %{ol!s£\/un. B&}o/n?\us%#3{ [c\!e/£v&}ap? m&\e£/{%tn!i|:\ £v!al/X?/+}va/\£l&/Y/=v/a%£l(?X+Y!/)\?£; E!x/{a£\&m?p]?}/\|l£e: ?%\"|3?£+[\!5={|%8"</endofc> ...', '$'
outputWOCode    db '**************************************************************************************************************************************************','$'
outputGenerated db 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx','$'
outputBonus     db '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++','$'
  
UPPER           db 0
LOWER           db 0
ENDOF           db 0
FLU             db 0   
FIRSTCHAR       db 0
TEMP            dw 0  