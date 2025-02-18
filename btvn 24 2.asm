.model tiny
;ax tinh nhung qua banana, luu banana vao thanh ghi
;bx chi tro vao banana
;cx loop
;dx nhap xuat banana

.code
    org 100h

;mssv: 001206002991
;vi la nhap 1 so tu 0 den 9
;cac truong hop sau se ko chay dc
;so lon hon 9 ex 10 11 12...
;so am ex -1 -2 -3...
;so thap phan ex 1.1 1.2 1.3...
;chu cai va ko phai so ex a b c...
;luong long nhat the a1 b2 3a 4b 4$ $r hoac bat ki 2 ascii nao khac
;vi trong suot qua trinh chay code nhan thay "bh" ko thay doi nen ta lay "bh" lam diem de ket thuc neu chay qua cac dieu kien tren
;bh >2 -> jump toi endchuongtrinh
;khi ta bam enter se bat dau xu li chuoi vua nhap
;
message:
    mov dx,offset msg1
    mov ah,9
    int 21h
input:
    cmp bh,2
    je endchuongtrinh
    mov ah,1
    int 21h
    
    cmp al,13
    jne vikophaienter
    je vibamenter
vikophaienter:
    push ax
    pop ax
    mov bl,al
    push bx
    inc bh

    jmp input


vibamenter:
    pop ax
    push ax
    sub al,48
    shr al,4
    jnz dmm

    

sodanhap:   
    mov dx,offset msg2
    mov ah,9
    int 21h
    
    mov dl,bl
    mov al,bl
    push ax
    mov ah,2
    int 21h




sosanh:

    
    mov bl,49 ;socuoicuamssv
    pop ax
    push bx
    cmp al,bl
    jne khacko
    je bangnhau
khacko:
    pop bx
    pop ax
    
    push cx
    sub bl,al
    ;cmp cf,1
    jc bllonhonal
    jnc allonhonbl ;dont know sao no bi reverse nhung work = keep 
bllonhonal:
    mov dx,offset lonhon
    jmp print
allonhonbl:
    mov dx,offset behon
    jmp print
bangnhau:
    mov dx,offset msg4
    jmp print
dmm:
    jmp endchuongtrinh   ;not sure tai sao de o day thi ko bi end som :/
print:
    push ax
    mov ah,9
    int 21h
    mov dx ,offset cac
    mov ah,9
    int 21h






pop ax
mov m,al ;m = tong qua chuoi ( ngay sinh) must be 14
 ;cho 14 vao bl de chi tro
mov bl,m
;copy lai function convert binary cu :v

mov cx, 8
print2:
    mov ah,2
    mov dl, '0'
    test bl, 10000000b
    jz zero
    mov dl, '1'

zero:
    int 21h
    shl bl, 1

loop print2

mov dl, 'b'
int 21h


mov dx,offset format
mov ah,9
int 21h



endchuongtrinh:
    mov ah,4ch
    int 21h   

msg1 db 'Nhap mot so: ','$'
msg2 db 13,10, 'So da nhap: ','$'
;msg3 db 13,10, 'khong phai so thuoc 0 den 9'   not sure vi sao no in ca msg4 nen xoa luon cho lanh`
msg4 db " = 1 la ma so sinh vien$"
behon db " < 1 la ma so sinh vien$"
lonhon db " > 1 la ma so sinh vien$"
format db 13,10,"Nguyen Duc Anh - 001206002991$"
cac db 13,10,"$"
m db 0
