.include m328Pdef.inc
.org 0x0000

ldi	XL,0xff		;Carrega X com x0100
ldi	XH,0x08

;Configuras as portas


config_teclado:
ldi R17, 0xff
out DDRD, R17
ldi R16,0x00       ;carrega o valor 00000000 em R16
out PORTD,R16
out DDRC,R16       ;Configura portaC como entrada, para cofigurar o pino que desliga o armazenamento
out DDRB,R16       ;configura PortaB como entrada
ldi R16,0b00_00_11_11
out PORTB,R16        ;Pinos 7-4 pull-up pinos 3-0 pull-down
ldi	R16, 0b0100000
out	PINC,R16

start:
ldi R17,0x00
in  R17,PORTB ;ler a porta B no registrador
ldi R18,0b00_00_11_11
CP R17,R18  ; fazer comapração enquanto a portaB for zero não armazena
BRNE armazena
rjmp start

armazena:
st -X,R17		;Primeiro decrementa X em uma unidade X = X - 1
sbic PINC,5	;pula proxima se um low for dados na porta C pino 5 compara se o pinC
rjmp start
rjmp leitura_mem;

leitura_mem:
ldi	XL,0xff		;Carrega X com x0100
ldi	XH,0x08
ld R16, -X
out PORTD,R16
ldi R18,0
CP R16,R18  ; fazer comapração enquanto a portaB for zero não armazena
BREQ wait;
rjmp leitura_mem;

wait:
nop
rjmp	wait		;reinicia wait










