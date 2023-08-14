# Tradutor de Código Morse
Neste projeto foi criado um dispositivo embarcado que reproduz quatro mensagens pré programadas em código morse. O software foi desenvolvido em linguagem Assembly para AVR ATmega328P.
O hardware deste tradutor inclui os componentes listados abaixo no setup mostrado na figura abaixo:

<p align="center">
  <img src="https://github.com/giovanni-br/MorseCode_AVR/blob/main/ckt.png" width="2000">
<p>

## Componentes
* Arduino uno - AVR ATmega328P;
* 1 Led; 
* 1 buzzer;
* 5 botões;
* 6 resistores (1-10k)


## Funcionamento:
Antes da seleção de cada mensagem, é necessário habilitar o dispositivo para leitura da porta digital vinculada aos botões de escolha; isto é feito pressionando o botão ligado a entrada D2, ligado por um fio laranja, destinado a ser o interrupt do sistema. Na sequência, a seleção da mensagem transmitida pelo dispositivo é processada ao pressionar um dos 4 botões disponíveis para a respectiva mensagem. 

As mensagens programadas para tradução são:
* SOS-PIND7
* LOVE U- PIND6
* ENFI-PIND5
* NOTA 10-PIND4 

A transmissão destas mensagens por código morse é realizada por ondas sonoras e luz visível através de um buzzer e um LED, possibilitando a dupla percepção da mensagem.

## Programação
A figura abaixo mostra os sinais utilizados para traduzir os caracteres alfanuméricos comuns da nossa língua em código morse. Neste sentido, a lógica da programação do nosso tradutor contemplou 5 subrotinas que compreendem os diferentes estados lógicos e tempos de delay estabelecidos no código Morse. 

<p align="center">
  <img src="https://github.com/giovanni-br/MorseCode_AVR/blob/main/International_Morse_Code.png" width="400">
<p>


Para este trabalho, foi determinado com base de tempo - unidade - ¼ de segundo. Desta forma, as subrotinas para os comando _ponto_ e _espaco_msm_letra_, por exemplo, configuram um delay de 250 milisegundos no timer do AVR com pull-up e pull-down, respectivamente, na saída dos periféricos. 
 
O programa foi desenvolvido utilizando o timer 1 do AVR com prescaler 1024 a fim de alcançar o range de tempo máximo definido dentro dos sinais em código morse. O delay máximo corresponde ao sinal “espaço entre duas palavras”, sendo estabelecido como 7 unidades de tempo. Desta forma, a subrotina _espaco_palavra_ deverá configurar um delay de 1,75 segundos em pull-down.

Dentro de cada subrotina é verificado o estado dos registradores TCNT1H e TCNT1L; passo necessário para a espera do tempo determinado entre caracteres em cada mensagem. Abaixo, na tabela, é exibida o tempo de delay e o valor de comparação que deve-se alcançar no registrador TCNT em cada subrotina: 

Subrotina        | delay               | decimal | hexadecimal
---------------  | ------------------- | ------- |------------
ponto            | 1 unidade = 250 ms  | 3906    | 0F42
linha            | 3 unidade = 750 ms  | 11719   | 2DC7
espaco_msm_letra | 1 unidade = 250 ms  | 3906    | 0F42 
espaco_letra     | 3 unidades = 750 ms | 11719   | 2DC7
espaco_palavra   | 7 unidades = 1750 ms| 27344   | 6AD0



**Nota:** Para fins de simulação, (onde o clock do timer corre mais devagar que na vida real), alteramos a configuração do timer que originalmente tem um prescaler de x1024 para um prescaler de x64. Por isso, a linha 378 do código estará comentada. Ademais, alterou-se para 0x0011 a unidade de tempo; originalmente uma unidade de tempo corresponde a 0x0F42.

# Referências:
* https://en.wikipedia.org/wiki/Morse_code
* https://github.com/eerimoq/hardware-reference/blob/master/Atmel/atmega328p%20reference%20manual.pdf






