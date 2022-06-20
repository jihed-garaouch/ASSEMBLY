; 16-bit COM file example
; nasm hellocom.asm -fbin -o hellocom.com
; to run in MS DOS / DosBox: hellocom.com
  org 100h 
 ;macro wait 
 %macro delay 0
  pusha
  mov al ,0 
  mov ah ,86h 
  mov cx ,5
  mov dx ,0
  int 15h 
  popa
  %endmacro 
section .text 
  global _start
_start:
  mov al, 13h ;desired video mode  320 *200 ;256 color
  mov ah, 0  ;set video mod 
  int 10h     ; 
  mov ax ,0A000h
  mov es,ax 
  xor di ,di 

  mov bh , 135
  mov bl , 180
_main: 
  call _PrintAliens
  call _DrawShip
 
  Loop:
  delay
  mov ah ,01h
  int 16h 
  jz Loop
  mov ah ,00h 
  int 16h 
  cmp al ,'q'
  je _Left  
  cmp al ,'Q'
  je _Left 
  cmp al ,'d'
  je _right 
  cmp al ,'D'
  je _right 
   cmp al ,'Z'
  je _shot_fired_FROM_player
  cmp al ,'z'
  je _shot_fired_FROM_player
  jmp  Loop
  _shot_fired_FROM_player:
  pusha
  call _UNPrintAliens
  call _movAliens_Array_X
  mov dx ,bx 
  mov bx , [player_shot]
  cmp bx , 0
  jne _fin 
  mov bx ,dx 
  
  dec bl
  call _PrintToXandY
  mov [player_shot] ,bx 
  mov al ,08h
  mov[es:di] , al  
  _fin:
  popa 

  jmp _main
 
_movShot: 
  
  pusha
   
  mov bx , [player_shot]
  cmp bx, 0
  je finsih 
  call _PrintToXandY
  mov al,00h 
  mov[es:di] , al  
  dec bl
  call _PrintToXandY
  mov [player_shot] ,bx 
  mov al,08h 
  mov[es:di] , al  
  finsih:
  popa 
  ret 

_Left : 
  call _movShot
  call _UnDrawShip
  call _UNPrintAliens
  call _movAliens_Array_X
  sub bh , 2 
  mov al , 0h
  jmp _main
_right : 
  call _movShot
  call _UnDrawShip
  call _UNPrintAliens 
  call _movAliens_Array_X
  add bh , 2 
  mov al , 0h
  jmp _main
  hlt 
  
_DrawShip: 
  pusha       ;00011000 
         ;10111101
  call _PrintToXandY         ;00100100
  mov al , 05h
  add di , 3 
  mov [es:di] , al        
  call _PrintToXandY    
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  add bl , 1  
  call _PrintToXandY 
  mov [es:di] , al
  add di, 2
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  add bl , 1 
  call _PrintToXandY
  add di , 3  
  mov [es:di] , al
  add di , 3
  mov [es:di] , al
  add bl , 1 
  call _PrintToXandY  
  mov [es:di] , al
  inc di
  mov [es:di] , al
  add di , 4
  mov [es:di] , al
  inc di
  mov [es:di] , al
  popa 
  ret 
  _UnDrawShip: 
  pusha       ;00011000 
         ;10111101
  call _PrintToXandY         ;00100100
  mov al , 00h
  add di , 3 
  mov [es:di] , al        
  call _PrintToXandY    
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  add bl , 1  
  call _PrintToXandY 
  mov [es:di] , al
  add di, 2
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  inc di 
  mov [es:di] , al
  add di , 2 
  mov [es:di] , al
  add bl , 1 
  call _PrintToXandY
  add di , 3  
  mov [es:di] , al
  add di , 3
  mov [es:di] , al
  add bl , 1 
  call _PrintToXandY  
  mov [es:di] , al
  inc di
  mov [es:di] , al
  add di , 4
  mov [es:di] , al
  inc di
  mov [es:di] , al
  popa 
  ret
  _PrintAliens : 
  pusha
  mov bx , alien_x_y 
  mov cx , [bx]
  inc bx
  add cx , 0FFh
  mov cx ,[bx]
  push bx
  mov bx ,cx 
  call _DrawAlien
  pop bx 
  inc bx
  mov cx , [bx]
  inc bx
  add cx , 0FFh
  mov cx ,[bx]
  push bx
  mov bx ,cx 
  call _DrawAlien
  pop bx 
  popa
  ret 
   _UNPrintAliens : 
  pusha
  mov bx , alien_x_y 
  mov cx , [bx]
  inc bx
  add cx , 0FFh
  mov cx ,[bx]
  push bx
  mov bx ,cx 
  call _UNDrawAlien
  pop bx 
  inc bx
  mov cx , [bx]
  inc bx
  add cx , 0FFh
  mov cx ,[bx]
  push bx
  mov bx ,cx 
  call _UNDrawAlien
  pop bx 
  
  popa
  ret 

  _DrawAlien: 
  pusha
  mov al, 06h 
  call _PrintToXandY  ; 10011001 
  mov [es:di] ,al 
  add di , 3 
  mov [es:di] ,al
  inc di  
  mov [es:di] ,al 
  add di, 3
  mov [es:di] ,al     
  add di,312      
  inc di 
  mov [es:di] ,al         ;01011010
  add di , 2 
  mov [es:di] ,al 
  inc di 
  mov [es:di] ,al 
  add di,2 
  mov [es:di] ,al 
  inc di 
  add di ,312 ; 00111100 
  add di ,3 
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  add di, 2
  add di ,312
  inc di 
  mov [es:di] ,al
  add di ,5
  mov [es:di] ,al
  popa 
  ret  

   _UNDrawAlien:  ; same drawalien procedure but with color  black 
  pusha
  mov al, 00h 
  call _PrintToXandY  ; 10011001 
  mov [es:di] ,al 
  add di , 3 
  mov [es:di] ,al
  inc di  
  mov [es:di] ,al 
  add di, 3
  mov [es:di] ,al     
  add di ,312 ; 00111100          
  inc di 
  mov [es:di] ,al         ;01011010
  add di , 2 
  mov [es:di] ,al 
  inc di 
  mov [es:di] ,al 
  add di,2 
  mov [es:di] ,al 
  inc di 
   add di ,312 ; 00111100      ; 00111100 
  add di ,3
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  inc di 
  mov [es:di] ,al
  add di, 2
  add di ,312 ; 00111100     
  inc di 
  mov [es:di] ,al
  add di ,5
  mov [es:di] ,al
  popa 
  ret  
  
  

_PrintToXandY : ;bh :x ,bl :y ==> scrennpos in di es 
  push bx  
  push ax
  mov ah,0
  mov al,bh 
  mov di ,ax 
  mov ah , 0
  mov al , bl  
  mov bx ,320
  mul bx    ;
  add di ,ax 
  mov ax , 0A000h 
  MOV es ,ax 
  pop ax 
  pop bx
  ret 
_movAliens_Array_X: 
  pusha 
  mov cx,0 
  mov bx ,alien_x_y
  
  _L:
  mov dx ,[bx]
  
  add dx ,10
  mov [bx] , dx 
  inc bx 
  inc bx
  inc cx
  cmp cx , 3
  jne _L
  popa
  ret 

_movAliens_Array_Y: 
  pusha 
  mov cx,0
  _Lo:
  mov bx ,alien_x_y
  inc bx 
  mov dx ,[bx] 
  add dx ,10
  mov [bx] , dx 
  inc bx 
  inc bx
  inc cx 
  cmp cx , 3
  jne _Lo
  popa
  ret 
section .data
  ; program data
alien_x_y  DB  50 ,100 ,150  ,100 ,70 ,100 ,80 ,100 ,;  9 alien  alien_x_y[i mod 2 ==0 ] => x and i mod 2 = 1 => y 
alien1_shot  db 0
alien2_shot db 0
alien3_shot db 0
player_shot DB 0
player_shot2  DB 0
 