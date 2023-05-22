; @author   Sude Cakmak
; @date     2023.04.15
; @brief    152120201044_BilMim-A-2223B_UYG1


lea SI, text

call calculateLength    
                     
                     
; Divide length by 3
mov AX, CX
mov BL, 3
div BL
mov CL, AL


lea SI, text
 
call myDecAlg   ; Call decryption algorithm  

hlt
       
    
;text DB  022,229,205,010,173,217,018,104,203,022,229,205,010,173,217,018,104,203,018,057,203,017,044,211,020,057,229,010,170,207,015,107, 211,195,173,123,208,062,097,222,184,067,209,186,093,'$' ; example
text DB  015,037,231,017,237,223,011,040,117,222,057,099,221,061,101,222,061,103,'$' 
                      
                                         
; Calculates the length of a text
proc calculateLength
    c1: lodsb       
        cmp al, '$' ; compares 8-bit accumulator with '$' character.
        jz rt       
        inc cx      
        jmp c1      
    rt: ret         

          
         
; Encyrption Algorithm
proc myEncAlg
    encloop:
        
        lodsb
        ror AL, 2    
        mov DH, AL
        
        lodsw
        neg AX
        mov DL, AL    
        rol AH, 1
        dec AH      
        xor DX, 0CEFAh
        add DL, 0A9h
        mov AL, DL
        
        stosb
        mov AL, DH
        not AX
        
        stosw    
        
        loop encloop 
        ret
   
   
   
; Decryption Algorithm 

; To decrypt the encrypted code, 
; perform the reverse of each operation done in the encryption algorithm 

proc myDecAlg
    decloop:
    
        lodsb       
        mov dl, al
        sub dl, 0A9h  
           
        lodsw          
        not ax         
        mov dh, al  
        inc ah 
        ror ah, 1 
        xor dx, 0CEFAh       
       
        rol dh, 2        
        mov al, dl          
        neg ax  
        
        ; write to text 
                            
        mov [text+DI], DH  
        inc DI
            
        mov [text+DI], AL  
        inc DI
            
        mov [text+DI], AH  
        inc DI
        
        loop decloop
        
        ret
   