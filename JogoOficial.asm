    .model small

    .stack 100H

    .data 
        DelaySetorH dw 3Dh;01EH;
        DelaySetorL dw 0900h;0C240H ; 3D0900H = 4.000.000 de microseg

        DelayMovimentoH dw 0
        DelayMovimentoL dw 0C350H ;50.000 de microseg = 50ms
        
        DivTimer db 20 ;divisor do clock (50ms) para obter 1 segundo / alterar caso seja alterado o delay de movimento (-1 para ajustar com todos os processos)

        ;variáveis para calcular número aleatório
        rangeAleatorio dw 0
        deslocAleatorio dw 0
        numAleatorio dw 0

        contadorMusicaMenu db 0
        velocidadeMusicaMenu db 4 ;quanto menor, mais rápido
        notaMusicaMenu dw 0
        vetorMusicaMenu dw 440,440,440,440,500,660,1046,830,660,440,440,440,440,500,660,1046,830,660,440,440,440,440,500,660,1046,830,660,440,440,440,440,500,1046,830,660,500
        tamanhoMusicaMenu equ $ - vetorMusicaMenu

        vetorMusicaGameOver dw 698,659,587,523,494,494,440
        tamanhoMusicaGameOver equ $ - vetorMusicaGameOver
        
        vetorMusicaVencedor dw 523,659,698,1047,1047,698,1047,1047,1047,1047,1047
        tamanhoMusicaVencedor equ $ - vetorMusicaVencedor
        
        vetorMusicaSetor dw 830,659,523,523,440,523,659,830,830,830,830
        tamanhoMusicaSetor equ $ - vetorMusicaSetor

        LimiteCima dw 4207
        LimiteBaixo dw 50287 
        PosicaoAliadaInicial dw 27247
        PosicaoAliada dw 0
        PosicaoAliadaComparacao dw 0
        PosicaoInimigaComparacao dw 0
        FlagAliadaFrente db 0

        DeslocamentoTiro dw 0
        PosicaoTiro dw 0

        FlagTiro db 0
        FlagInimigo dw 0
        
        FlagApagaAliada db 0

        DeslocamentoInimigo dw 225
        DirecaoInimigo dw 0
        PosicaoInimiga dw 0
        PosicaoInimigaColuna dw 0
        PosicaoInimigaLinha dw 0
        CorInimiga db 9
        CorAliada db 15
        
        contNavesInimigasAtravessaram dw 0
        contNavesInimigas dw 0
        contDeslocamentoHorizontalInimigo dw 0

        vetorPosicaoInimigos dw 270 dup (0)
        vetorPosicaoInimigaLinha dw 270 dup (0)
        vetorDirecaoInimigos dw 270 dup (0)
        vetorContDeslocamentoHorizontalInimigo dw 270 dup (0)
        vetorDeslocamentoInimigos dw 270 dup (225)
        vetorFlagInimigos dw 270 dup (0)


        SpriteTiro  db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0
                    db 15 dup (0)
                    db 15 dup (0)
                    db 15 dup (0)
                    db 0,0,0,0,0,0,15,15,15,15,15,15,15,15,15
                    db 15 dup (0)
                    db 15 dup (0)
                    db 15 dup (0)
                    db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0
        
        SpriteNave  db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0
                    db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,15,15,15,15,15,15,15,0,0,0,0,0,0
                    db 0,0,15,15,15,15,15,15,15,15,15,15,15,15,15
                    db 0,0,15,15,15,15,15,15,15,0,0,0,0,0,0
                    db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,15,15,0,0,0,0,0,0,0,0,0,0,0
                    db 15,15,15,15,15,15,15,15,15,0,0,0,0,0,0

        SpriteInimiga   db 0,0,0,0,0,0,0,0,0,9,9,9,9,9,9
                        db 0,0,0,0,0,0,0,0,0,9,9,0,0,0,0
                        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,9,9,9,9,9,0,0,0,0,0,0
                        db 9,9,9,9,9,9,9,9,9,9,9,9,9,0,0
                        db 0,0,0,0,9,9,9,9,9,0,0,0,0,0,0
                        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,0,0,0,0,0,9,9,0,0,0,0
                        db 0,0,0,0,0,0,0,0,0,9,9,9,9,9,9

        explosao1       db 15 dup (0) 
                        db 0,0,0,0,14,14,14,14,14,14,14,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,0,0,14,14,14,0,0,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,0,0,14,14,14,0,0,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,14,14,14,14,14,14,14,0,0,0,0
                        db 15 dup (0) 

        explosao2       db 0,0,0,12,12,12,12,12,12,12,12,12,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,0,12,12,12,12,12,0,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,0,0,0,12,0,0,0,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,0,0,12,12,12,12,12,0,0,0,0,0
                        db 15 dup (0) 
                        db 0,0,0,12,12,12,12,12,12,12,12,12,0,0,0

        SpriteTerreno   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0
                        db 0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0
                        db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0
                        db 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0
                        db 2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1
                        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,1,1,1,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 
                        db 480 dup (1) 

        DeslocamentoTerreno dw 0

        SpriteVazio db 135 dup (0)
        
        PosicaoElemento dw 0
        PosicaoVazio dw 0

        CorRemap db 0


        Titulo1 db '----------------------------------------    __ __      ____ __                     / //_/____ / __// /_ ___ _ ____        / ,<  /___/_\ \ / __// _ `// __/       /_/|_|     /___/ \__/ \_,_//_/         '
        TamanhoTitulo1 equ $ - Titulo1

        Titulo2 db '    ___    ____ __  ___       ___   ____   / _ |  / __//  |/  /__ __ ( _ ) / __/  / __ | _\ \ / /|_/ / \ \ // _  |/ _ \  /_/ |_|/___//_/  /_/ /_\_\ \___/ \___/                                         ----------------------------------------'
        TamanhoTitulo2 equ $ - Titulo2
        
        TituloSetor1 db '      ____       _               _           / ___|  ___| |_ ___  _ __  / |          \___ \ / _ \ __/ _ \| .__| | |           ___) |  __/ || (_) | |    | |          |____/ \___|\__\___/|_|    |_|     ' 
        CorTituloSetor1 db 6

        TituloSetor2 db '    ____       _               ____        / ___|  ___| |_ ___  _ __  |___ \       \___ \ / _ \ __/ _ \| `__|   __) |       ___) |  __/ || (_) | |     / __/       |____/ \___|\__\___/|_|    |_____|   '   
        CorTituloSetor2 db 8 

        TituloSetor3 db '    ____       _               _____       / ___|  ___| |_ ___  _ __  |___ /       \___ \ / _ \ __/ _ \| `__|   |_ \        ___) |  __/ || (_) | |     ___) |      |____/ \___|\__\___/|_|    |____/    ' 
        CorTituloSetor3 db 5
        
        TextoGameOver1 db '        ____                                   / ___| __ _ _ __ ___   ___             | |  _ / _` | `_ ` _ \ / _ \            | |_| | (_| | | | | | |  __/             \____|\__,_|_| |_| |_|\___|      '
        TextoGameOver2 db '       / _ \__   _____ _ __                   | | | \ \ / / _ \ `__|                  | |_| |\ V /  __/ |                      \___/  \_/ \___|_|               '
        TextoGameOverTecla db 'Pressione qualquer tecla',10,24 dup (08),' para voltar ao menu...'
        TamTextoGameOverTecla equ $ - TextoGameOverTecla

        TextoVencedor db  ' _   __                    __         __| | / /__ ___  _______ ___/ /__  ____/ /| |/ / -_) _ \/ __/ -_) _  / _ \/ __/_/ |___/\__/_//_/\__/\__/\_,_/\___/_/ (_)  '
        TamTextoVencedor equ $ - TextoVencedor
        
        Jogar db 1 ;variavel para controle menu

        Jogando db 0 ;variavel para controle jogando
        
        textoJogar db 218,196,196,196,196,196,196,196,191,10,08,08,08,08,08,08,08,08,08,179,' JOGAR ',179,10,08,08,08,08,08,08,08,08,08,192,196,196,196,196,196,196,196,217
        tamanhoTextoJogar equ $ - textoJogar;
        textoSair db 218,196,196,196,196,196,196,196,191,10,08,08,08,08,08,08,08,08,08,179,' SAIR  ',179,10,08,08,08,08,08,08,08,08,08,192,196,196,196,196,196,196,196,217
        tamanhoTextoSair equ $ - textoSair;

        corJogar db 12
        corSair db 15
        corTerreno db 6
        
        CorAliadaAtual db 15
        
        contNaves dw 8

        vetorPosNaves dw 5120,11520,17920,24320,30720,37120,43520,49920
        vetorFlagNaves db 1,1,1,1,1,1,1,1
        vetorCorNaves db 9,10,12,13,14,7,5,4
        vetorCorOriginalNaves db 9,10,12,13,14,7,5,4

        ColidiuAliada db 0

        setorAtual db 1 ;controla o setor atual

        textoScore db 'SCORE: '
        Score dw 0
        ScoreSTR db 8 dup (?)
        tamanhoScoreSTR equ $ - ScoreSTR

        textoTimer db 'TEMPO: '
        Timer db 0
        TimerSTR db 2 dup (?)
        tamanhoTimerSTR equ $ - TimerSTR
        
        TempoSetor db 60
        ContTimer db 0
        contTimerInimigo db 0
        contTimerInimigoLimite db 20 ; a cada quanto tempo o inimigo novo aparece. 20 = 1 por segundo

        contNavesInimigasVivas db 0
        maxNavesInimigas db 10

        RotacaoAleatorio db 0

    .code 

        desenha_elemento proc 
            push ax
            push bx
            push cx
            push dx
            push di
            push es
            push ds
                
                mov ax, @data
                mov ds, ax

                mov ax, 0A000h
                mov es, ax

                mov di, PosicaoElemento
                ;si contém o offset da sprite

                ; Número de linhas
                mov dx, 9

            desenha_linha:
                ; Definir quantos bytes mover por linha (15 bytes por linha)
                mov cx, 15

                ; Copiar 15 bytes da Sprite para a memória de vídeo
                rep movsb

                ; Ajustar (DI) para a próxima linha
                ; Avança 320 - 15 bytes  (próxima linha) para a memória de vídeo
                add di, 305

                dec dx
                jnz desenha_linha

            pop ds  
            pop es
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        desenha_tiro proc
            push ax
            push si

            mov ax, PosicaoTiro
            mov PosicaoElemento, ax

            mov si, offset SpriteTiro
            call desenha_elemento

            pop si
            pop ax
        ret
        endp  

        remapeia_cor proc
                push ax
                push bx
                push cx
                push si
                push ds

                mov ax, @data
                mov ds, ax
                
                ;posicao do sprite em si
                ; Número de bytes no sprite  (15 bytes * 9 linhas = 135 bytes)
                mov cx, 135

            substituir_cor:
                ; Verifica o valor do byte atual em SpriteNave
                lodsb              ; Carrega o byte apontado por DS:SI em AL e incrementa SI
                cmp al, 0          ; Compara o byte com 0
                jz proximo_byte    ; Se o byte for 0, pula para o próximo

                ; Substitui o byte por CorRemap se for maior que 0
                mov bl, CorRemap 
                mov [si-1], bl

            proximo_byte:
                ; Decrementa o contador de bytes e repete até o final
                loop substituir_cor

                pop ds
                pop si
                pop cx
                pop bx
                pop ax
        ret
        endp

        desenha_nave proc
                push ax
                push si

                mov ax, PosicaoAliada
                mov PosicaoElemento, ax

                mov al, CorAliada
                mov CorRemap, al

                mov si, offset SpriteNave

                call remapeia_cor
                call desenha_elemento

                pop si
                pop ax
        ret
        endp

        desenha_vazio proc
            push ax
            push si

            mov ax, PosicaoVazio
            mov PosicaoElemento, ax

            mov si, offset SpriteVazio
            call desenha_elemento

            pop si
            pop ax
        ret
        endp

        desenha_nave_inimiga proc
            push ax
            push si

            mov ax,0A000h    
            mov es,ax   

            mov ax, PosicaoInimiga
            mov PosicaoElemento, ax

            mov si, offset SpriteInimiga

            call desenha_elemento

            pop si
            pop ax

        ret
        endp  

        apaga_elemento proc
            push si
            ;recebe posição em ax
            mov PosicaoElemento, ax

            mov si, offset SpriteVazio
            call desenha_elemento

            pop si
        ret
        endp 
        
        escreveTexto proc
            push ax
            push bp
            push si

                mov AX, 1300h        
                mov BP, SI
                int 10h

            pop si
            pop bp
            pop ax
        ret
        endp

        writeTitulo proc
            ; DH , DL  linha,coluna para começar a escrever
            ; CX tamanho do texto
            ; BL cor do texto
            ; BP ponteiro para o endereço do texto
            push AX
            push BX
            push CX 
            push BP
            push ES

                mov AX, DS 
                mov ES, AX
            
                MOV SI, offset Titulo1

                ;coluna
                mov DL, 0
                mov DH, 1
                mov CX, TamanhoTitulo1
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto
            
                MOV SI, offset Titulo2

                ;coluna
                mov DL, 0
                mov DH, 6
                mov CX, TamanhoTitulo2
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto

            pop ES
            pop BP   
            pop CX
            pop BX
            pop AX
        ret
        endp  
        
        delay proc   
            push ax
                mov ah, 86h    ; função de espera
                int 15h
            pop ax
        ret
        delay endp

        ; Escreve em uma String com posição salva em DI numero
        ; de 16 bits armazenado no registrador AX
        ESC_UINT16 proc 
            push AX      ; Salvar registradores utilizados na proc
            push BX
            push CX
            push DX 
                
                mov BX, 10   ; divisões sucessivas por 10
                xor CX, CX   ; contador de dígitos

                ; Verificar se o número é menor que 0
                cmp ax, 0
                jge MAIOR_QUE_0
                    xor AX,AX ;zera se for menor que zero
                MAIOR_QUE_0:
                ; Verificar se o número é menor que 10
                cmp AX, 10
                jl MENOR_QUE_10
                
            LACO_DIV:
                xor DX, DX   ; zerar DX pois o dividendo é DXAX
                div BX       ; divisão para separar o dígito em DX
                
                push DX      ; empilhar o dígito
                inc CX       ; incrementa o contador de dígitos
                
                cmp AX, 0    ; AX chegou a 0?
                jnz LACO_DIV ; enquanto AX diferente de 0 salte para LACO_DIV
                jmp FIM_ESC_DIG
            
            MENOR_QUE_10:
                ; Se o número for menor que 10, exibir "0" primeiro
                mov DL, '0'  ; Carregar o caractere '0'
                mov [DI], DL ; Escreve '0' na string
                inc DI       ; Avança DI para a próxima posição
                push AX      ; Empilha o valor atual de AX como o único dígito
                inc CX       ; Incrementa o contador para 1 dígito
                
            FIM_ESC_DIG:
            LACO_ESCDIG:   
                pop DX       ; desempilha o dígito    
                add DL, '0'  ; converter o dígito para ASCII
                mov [DI],DL
                inc DI
                loop LACO_ESCDIG    ; decrementa o contador de dígitos
                
            pop DX       ; Restaurar registradores utilizados na proc
            pop CX
            pop BX
            pop AX
        ret     
        endp           

        desenhaStatus proc

            push AX
            push BX
            push CX
            push DX
            push DI


            ; RESETA ES
            mov AX, DS        
            mov ES, AX

                MOV SI, offset textoScore
                ;coluna
                mov DL, 0
                mov DH, 0
                mov CX, 6
                XOR BX, BX
                ;cor do texto
                MOV BL, 15
                
                call escreveTexto
                
                mov AX, Score
                mov DI, offset ScoreSTR
                call ESC_UINT16
                
                MOV SI, offset ScoreSTR
                ;coluna
                mov DL, 6
                mov DH, 0
                mov CX, tamanhoScoreSTR
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto

                MOV SI, offset textoTimer
                ;coluna
                mov DL, 30
                mov DH, 0
                mov CX, 7
                XOR BX, BX
                ;cor do texto
                MOV BL, 15

                call escreveTexto

                xor AX,AX
                mov AL, Timer
                mov DI, offset TimerSTR
                call ESC_UINT16

                MOV SI, offset TimerSTR
                ;coluna
                mov DL, 37
                mov DH, 0
                mov CX, tamanhoTimerSTR
                XOR BX, BX
                ;cor do texto
                MOV BL, 10

                call escreveTexto


            pop DI
            pop DX
            pop CX
            pop BX
            pop AX            
        ret
        endp

        limpaStatus proc
            push AX
            push BX
            push CX 
            push DX 
            push ES

                mov ax,0A000h    ; segmento do buffer de v?deo
                mov es,ax   ; coloca em es

                mov cx,10
                xor bx,bx
                LACOAPAGASTATUS:
                    push cx
                        xor ax,ax
                        xor di,di   ; zerar di, ES:DI aponta para mem?ria v?deo
                        mov di,bx
                        mov cx,320     ; quantidade de vezes que deve escrever
                        cld         ; dire??o - para a frente
                        rep stosw   ; escreve caracter em ES:[DI]
                        add bx,320
                    pop cx
                    loop LACOAPAGASTATUS

            pop ES
            pop DX
            pop CX
            pop BX
            pop AX 
            
        ret
        endp
        
        desenha_elemento_terreno proc 
            push ax
            push bx
            push cx
            push dx
            push di
            push es
            push ds
                
                mov ax, @data
                mov ds, ax

                mov ax, 0A000h
                mov es, ax

                mov di, PosicaoElemento

                ; Número de linhas do terreno (20 linhas)
                mov dx, 20

            desenha_linha_terreno:
                ; Definir quantos bytes mover por linha (320 bytes por linha)
                mov cx, 320
                rep movsb
                
                add si, 160 ;pula 160 bytes para a proxima linha
                dec dx
                jnz desenha_linha_terreno

            pop ds  
            pop es
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        remapeia_cor_terreno proc
                push ax
                push bx
                push cx
                push si
                push ds

                mov ax, @data
                mov ds, ax
                
                ;posicao do sprite em si
                mov cx, 9600

            substituir_cor_terreno:
                lodsb              ; Carrega o byte apontado por DS:SI em AL e incrementa SI
                cmp al, 0          ; Compara o byte com 0
                jz proximo_byte_terreno    ; Se o byte for 0, pula para o próximo
                cmp al, 2
                jz substituiLago    ; Se o byte for 2, desenha água
                cmp al, 11
                jz substituiLago    ; Se o byte for 11, desenha água

                ; Substitui o byte por corObjetoTela se for maior que 0
                mov bl, CorRemap ; Cor para remapear
                mov [si-1], bl
                jmp proximo_byte_terreno

                substituiLago:
                    mov bl, 11 ; Cor para remapear
                    mov [si-1], bl

            proximo_byte_terreno:
                ; Decrementa o contador de bytes e repete até o final
                loop substituir_cor_terreno

                ; Restaurar DS original
                pop ds
                pop si
                pop cx
                pop bx
                pop ax
        ret
        endp

        desenhaTerreno proc            
            push ax
            push si

            mov ax, 57920  ; linha 180 (20 linhas de 320 pixels)
            mov PosicaoElemento, ax

            mov si, offset SpriteTerreno
            add si, DeslocamentoTerreno

            call desenha_elemento_terreno

            pop si
            pop ax        
        ret
        endp

        movimentaTerreno proc
            push ax
            push si

            xor ax,ax
            add  DeslocamentoTerreno, 3
            mov ax, DeslocamentoTerreno

            cmp ax, 480
            jl fimMovimentaTerreno

                mov DeslocamentoTerreno, 0

            fimMovimentaTerreno:

            call desenhaTerreno
            pop si
            pop ax
        ret
        endp

        somTiro proc
            push bx
            push dx

                mov bx, 5000          ; Frequência
                call play_sound
                mov dx, 20000          ; Duração do som
                call delay_som
                call stop_sound

                mov bx, 3000          ; Frequência
                call play_sound
                mov dx, 40000          ; Duração do som
                call delay_som
                call stop_sound

            pop dx
            pop bx
        ret
        endp

        movimentaAliada proc

            push ax        
                mov al, 0            
                mov ah, 01h
                int 16h
                jz semCliqueJogo  ;sem input, ignorar
                
                mov ax, 0h 
                int 16h    ;pega o caracter do buffer

                cmp al, 20h
                je space
                cmp ah, 48h
                je up
                cmp ah, 50h
                je down             
                jmp semCliqueJogo 
                
                space:
                    mov al, FlagTiro
                    cmp al, 1
                    jge semCliqueJogo

                    call stop_sound
                    call somTiro
                    call stop_sound

                    inc FlagTiro

                    xor ax,ax
                    mov al , FlagTiro
                    cmp al, 1
                    je desenha_tiro1

                    semCliqueJogo:
                        jmp fim_clique_jogo

                    desenha_tiro1:
                        mov ax, PosicaoAliada
                        add ax, 15
                        mov PosicaoTiro, ax              
                        call desenha_tiro
                        jmp fim_clique_jogo

                up:
                    mov ax, PosicaoAliada
                    call apaga_elemento

                    mov al, CorAliadaAtual
                    mov CorAliada, al

                    mov ax, PosicaoAliada
                    cmp ax, LimiteCima
                    je limiteSuperior
                    sub PosicaoAliada, 1280
                limiteSuperior:
                    call desenha_nave  
                    jmp fim_clique_jogo

                down:
                    mov ax, PosicaoAliada
                    call apaga_elemento

                    mov al, CorAliadaAtual
                    mov CorAliada, al

                    mov ax, PosicaoAliada
                    cmp ax, LimiteBaixo;
                    je limiteInferior

                    add PosicaoAliada, 1280
                limiteInferior:    
                    call desenha_nave  

                fim_clique_jogo:

            pop ax

        ret
        endp

        movimentaTiro proc
            push ax 
            xor ax,ax
            mov al, FlagTiro
            cmp al, 0
            je semTiro

                xor bx,bx
                mov ax, PosicaoTiro
                call apaga_elemento

                xor ax,ax
                mov ax, DeslocamentoTiro
                cmp ax, 240
                jge parede1          
                xor ax,ax
                mov ax, PosicaoTiro
                add ax, 8
                mov PosicaoTiro, ax              
                call desenha_tiro
                xor ax,ax
                mov ax, DeslocamentoTiro
                add ax, 8
                mov DeslocamentoTiro, ax        
            
            jmp semTiro
            
            parede1:
                mov FlagTiro, 0
                mov DeslocamentoTiro, 0

            semTiro:
            pop ax
        ret
        endp

        verificaCorZero proc
            cmp al, 0
            je desenhaVazio
                call desenha_nave
                jmp fimDesenhaAliada
            desenhaVazio:
            mov al, FlagApagaAliada
            cmp al, 1
            jz fimDesenhaAliada
                call desenha_vazio
            fimDesenhaAliada:
        ret
        endp

        desenhaAliadas proc
            push ax
            push cx
            push si
            push di
            
                mov cx, 8
                xor si,si
                xor di,di

                lacoDesenhaAliadas:                    
                    mov ax, [vetorPosNaves + di]
                    mov PosicaoAliada, ax
                    mov PosicaoVazio, ax
                    mov al, [vetorCorNaves + si]
                    mov CorAliada, al
                    call verificaCorZero
                    inc si
                    add di, 2
                    loop lacoDesenhaAliadas
            pop di
            pop si
            pop cx
            pop ax
        ret
        endp

        desenhaAleatoriaInimiga proc
            push ax
            push bx
            push cx
            push dx

                mov ah, 00h
                int 1Ah
 
                mov ax,dx
                mov dx,ax
                xor dx, dx
                mov cx, 7 ;limitar para 7 o "range" do aleatorio
                div cx

                add dx, 1 ;coluna aleatoria em dx
                mov RotacaoAleatorio, dl


                mov rangeAleatorio,145
                mov deslocAleatorio,160
                call numeroAleatorio
                mov dx, numAleatorio

                mov PosicaoInimigaColuna, dx
                mov DeslocamentoInimigo, dx
                sub DeslocamentoInimigo, 78


                mov rangeAleatorio,144
                mov deslocAleatorio,13
                call numeroAleatorio
                mov dx, numAleatorio
                mov PosicaoInimigaLinha, dx

                ; Calcula a posição inimiga com base na coluna e linha aleatória
                mov ax, PosicaoInimigaLinha
                mov bx, 320
                mul bx ; Multiplica a linha por 320 (largura da tela)
                add ax, PosicaoInimigaColuna ; Adiciona a coluna para obter a posição final

                mov PosicaoInimiga, ax

            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        desenhaInimigas proc
            push si
            push ax
            push bx
            push cx
            push dx


            mov si, 0
            mov cx, contNavesInimigas
            dec cx
            LacoADDInimigas:
                add si, 2
                loop LacoADDInimigas

                    ;gera inimiga aleatoria:
                    call desenhaAleatoriaInimiga 

                    ;salva posição inicial e deslocamento no vetor de inimigas:
                    mov ax, PosicaoInimiga
                    mov [vetorPosicaoInimigos + si], ax
                    
                    mov ax, PosicaoInimigaLinha
                    mov [vetorPosicaoInimigaLinha + si], ax

                    mov ax, DeslocamentoInimigo
                    mov [vetorDeslocamentoInimigos + si], ax
                    mov [vetorFlagInimigos + si], 1
                    mov [vetorContDeslocamentoHorizontalInimigo + si], 0

                    mov rangeAleatorio,10
                    mov deslocAleatorio,1
                    call numeroAleatorio
                    mov ax, numAleatorio

                    test ax, 1             ; Testa o bit menos significativo (se for 0, é par)
                    jz numero_par          ; Se o bit 0 for zero, o número é par Sobe a nave
                    jmp numero_impar       ; Se não, é ímpar / desce a nave
                    
                    ;cmp ax, 0
                    ;je Descer
                    numero_par:
                        mov [vetorDirecaoInimigos + si], 1
                        jmp inc_cont_naves
                    numero_impar:
                        mov [vetorDirecaoInimigos + si], 0
                        jmp inc_cont_naves
                    
                    inc_cont_naves:
                    inc contNavesInimigasVivas

            pop dx
            pop cx
            pop bx
            pop ax
            pop si
        ret
        endp
        
        delay_som proc
            push dx

            delay_som_loop:
                dec dx
                jnz delay_som_loop
            
            pop dx
        ret
        endp

        ; Função para tocar um som com uma frequência específica
        play_sound proc
            push ax
            push bx
            push dx

            ; Configurar a frequência desejada
            mov ax, 1193         ; Parte baixa do valor 1193
            mov dx, 180         ; Parte alta do valor 180 (0x180)

            div bx               ; Dividir (DX:AX) pelo valor em BX

            mov bx, ax
        
            ; Enviar a configuração do timer
            mov al, 0B6h         ; Configuração para o modo 3 do timer (square wave)
            out 43h, al          ; Enviar comando ao timer (porta de controle)

            mov al, 0B6h          ; Configuração para o modo 3 do timer (square wave)
            out 42h, al          ; Envia a parte baixa do valor de controle para o timer
            mov al, bh           ; Carregar a parte alta de BX em AL
            out 42h, al          ; Enviar a parte alta para a porta do timer

            ; Ativar o PC Speaker
            in al, 61h           ; Ler a porta do speaker
            or al, 3             ; Ativar o speaker (bits 0 e 1)
            out 61h, al          ; Escrever de volta na porta para ativar o som

            pop dx
            pop bx
            pop ax
        ret
        endp

        ; Função para parar o som
        stop_sound proc
            push ax
                in al, 61h          ; Ler a porta do speaker
                and al, 0FCh         ; Desativar o speaker (bits 0 e 1)
                out 61h, al         ; Escrever de volta
            pop ax
        ret
        endp    

        somExplosao proc
                push ax
                push bx
                push cx
                push dx

                mov cx, 8             ; Número de tons para a explosão
                mov bx, 1600          ; Frequência inicial

                somExplosaoLoop:
                    ; Toca o som atual
                    call play_sound

                    ; Atraso curto para manter o som por um período audível
                    mov dx, 50000          ; Duração do som
                    call delay_som

                    ; Para o som
                    call stop_sound

                    ; Modifica a frequência para a próxima iteração
                    sub bx, 400           ; Reduz a frequência

                    ; Verifica se devemos parar ou continuar
                    cmp bx, 200           ; Evita que a frequência fique muito baixa
                    jle stop_som
                    loop somExplosaoLoop  ; Repetir enquanto CX não for zero

                stop_som:
                    call stop_sound

                ; Restaura os registradores
                pop dx
                pop cx
                pop bx
                pop ax
            ret
        endp

        explosao proc
            push ax
            push bx
            push cx
            push dx
            push es

            mov ax,0A000h    ; segmento do buffer de v?deo
            mov es,ax   ; coloca em es

            mov cx, 00H
            mov dx, 0FFFFH
            call delay

            mov bx,PosicaoInimiga
            push bx
            ;call apaga_nave_inimiga       

            mov ax, PosicaoInimiga
            call apaga_elemento     

            push si

            mov PosicaoElemento, bx

            mov si, offset explosao1
            call desenha_elemento

            pop si


            mov cx, 00H
            mov dx, 0FFFFH
            call delay

            pop bx

            mov ax, PosicaoInimiga
            call apaga_elemento
            
            push si

            mov PosicaoElemento, bx

            mov si, offset explosao2
            call desenha_elemento

            pop si

            call stop_sound
            call somExplosao
            call stop_sound
            
            pop es
            pop dx
            pop cx
            pop bx
            pop ax        
        ret
        endp

        verificaColisaoTiro proc    
            push ax
            push bx
            push cx
            push dx

            mov FlagInimigo, 1

            mov dx, PosicaoTiro
            ;add dx, 15
            mov cx, PosicaoInimiga
            add cx, 2880;2560

            cmp dx, cx          ; Comparar ponto superior direito de tiro com inferior esquerdo de inimigo
            ja fimColisao       ; Se borda superior de tiro >  inferior de inimigo, não colide

            mov dx, PosicaoTiro
            ;add dx, 15
            add dx, 2880;2560
            mov cx, PosicaoInimiga
            cmp dx, cx          ; Comparar ponto inferior direito de tiro com superior esquerdo de inimigo
            jb fimColisao       ; Se borda inferior de tiro < borda superior de inimigo, não colide
            
            mov cx, DeslocamentoTiro
            mov dx, DeslocamentoInimigo
            add dx, 20
            cmp cx, dx          ; Comparar DeslocamentoTiro com DeslocamentoInimigo
            jb fimColisao       ; Se DeslocamentoTiro < DeslocamentoInimigo, não colide

                ;verifica se o tiro já passou da nave
                sub cx, DeslocamentoInimigo
                cmp cx, 40
                jge fimColisao

            ; Se chegou aqui, os objetos colidem
                colide:
                    xor cx,cx
                    mov dx, 8480H
                    call delay

                    mov FlagTiro, 0
                    mov FlagInimigo, 0
                    mov DeslocamentoTiro, 0

                    ;call apaga_nave_inimiga
                    mov ax, PosicaoInimiga
                    call apaga_elemento
                    ;call apaga_tiro
                    mov ax, PosicaoTiro
                    call apaga_elemento

                    xor cx,cx
                    mov dx, 8480H
                    call delay

                    mov ax, Score
                    add ax, 100
                    mov Score, ax

                    call explosao

                        mov cx, 00H
                        mov dx, 0FFFFH
                        call delay

                    call explosao
                    ;call apaga_nave_inimiga
                    mov ax, PosicaoInimiga
                    call apaga_elemento
                    
                    mov FlagInimigo, 0
                    dec contNavesInimigasVivas

            fimColisao:

            pop dx
            pop cx
            pop bx
            pop ax

        ret
        endp

        verificaColisaoTiroTodas proc
            push ax
            push bx
            push cx
            push dx

            mov cx, contNavesInimigas
            mov si, 0

                verifica_colisao_tiro_loop:
                    cmp cx, 0
                    je fim_verifica_colisao_tiro

                    ; Carrega a posição do inimigo atual
                    mov ax, [vetorPosicaoInimigos + si]
                    mov dx, [vetorFlagInimigos + si]
                    cmp dx, 0
                    je proximo_inimigo_colisao
                    mov PosicaoInimiga, ax

                    ; Carrega o deslocamento do inimigo atual
                    mov ax, [vetorDeslocamentoInimigos + si]
                    mov DeslocamentoInimigo, ax

                    ; Verifica a colisão do tiro com o inimigo atual
                    call verificaColisaoTiro

                    ; Atualiza o flag do inimigo no vetor   
                    mov ax, FlagInimigo
                    mov [vetorFlagInimigos + si], ax

                proximo_inimigo_colisao:
                    ; Incrementa o índice do vetor
                    add si, 2
                    loop verifica_colisao_tiro_loop

                fim_verifica_colisao_tiro:

            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        verificaColisao proc    
            push ax
            push bx
            push cx
            push dx

            ;dx = posicao aliada
            ;cx = posicao inimiga

            mov PosicaoAliadaComparacao, dx
            mov PosicaoInimigaComparacao, cx

            add dx, 15
            add cx, 2880;2560

            cmp dx, cx          ; Comparar ponto superior direito de tiro com inferior esquerdo de inimigo
            ja fimColisaoAliada       ; Se borda superior de tiro >  inferior de inimigo, não colide

            mov dx, PosicaoAliadaComparacao
            add dx, 15
            add dx, 2560
            mov cx, PosicaoInimigaComparacao
            cmp dx, cx          ; Comparar ponto inferior direito de tiro com superior esquerdo de inimigo
            jb fimColisaoAliada       ; Se borda inferior de tiro < borda superior de inimigo, não colide
            
            cmp FlagAliadaFrente, 1
            je deslocamentoAliadaFrente
                mov cx,-60
                jmp comparaColunaAliada
            
            deslocamentoAliadaFrente:
                mov cx,-15 
                mov dx, DeslocamentoInimigo
                cmp cx, dx          ; Comparar DeslocamentoTiro com DeslocamentoInimigo                
                jle fimColisaoAliada       ; Se DeslocamentoTiro < DeslocamentoInimigo, não colide
                    mov cx, -40
                    cmp cx, dx
                    jge fimColisaoAliada
                        mov ColidiuAliada, 1 ;indica que colidiu
                        dec contNavesInimigasVivas
                        jmp fimColisaoAliada 
            
            comparaColunaAliada:
            mov dx, DeslocamentoInimigo
            cmp cx, dx          ; Comparar DeslocamentoTiro com DeslocamentoInimigo
            jle fimColisaoAliada       ; Se DeslocamentoTiro < DeslocamentoInimigo, não colide
                mov ColidiuAliada, 1 ;indica que colidiu
                dec contNavesInimigasVivas
            
            fimColisaoAliada:

            pop dx
            pop cx
            pop bx
            pop ax

        ret
        endp

        verificaColisaoNaves proc    
            push ax
            push bx
            push cx
            push dx
            push si
            push di

                mov FlagInimigo, 1

                xor dx,dx
                xor cx,cx

                mov dx, PosicaoAliada
                mov cx, PosicaoInimiga
                mov FlagAliadaFrente,1
                call verificaColisao

                cmp ColidiuAliada, 1
                jne PulaNavePrincipal

                    mov FlagInimigo, 0

                    call explosao

                    xor cx,cx
                    mov dx, 8480H
                    call delay

                    mov ax, PosicaoInimiga
                    call apaga_elemento

                    mov FlagInimigo, 0

                    mov ax, PosicaoAliada
                    call apaga_elemento

                    xor cx,cx
                    mov dx, 8480H
                    call delay

                    xor cx,cx
                    mov dx, 8480H
                    call delay

                    call desenhaProximaAliada

                    cmp contNaves, 0
                    
                    jne PulaNavePrincipal
                        call GameOver

            PulaNavePrincipal:

            mov cx, 8
            xor si, si
            xor di, di

                lacoVerificaColisaoAliadas:     
                    push cx               
                    mov al, [vetorFlagNaves + si]
                    cmp al, 0
                    je proximaNave
                        mov dx, [vetorPosNaves + di]
                        mov cx, PosicaoInimiga
                        mov FlagAliadaFrente,0
                        call verificaColisao
                        
                        cmp ColidiuAliada, 1
                        jne proximaNave

                        xor al,al
                        mov [vetorFlagNaves + si], al
                        mov [vetorCorNaves + si], al

                        mov ColidiuAliada, 0

                        call somExplosao

                        xor cx, cx
                        mov dx, 8480H
                        call delay

                        mov ax, PosicaoInimiga
                        call apaga_elemento

                        mov FlagInimigo, 0
                        dec contNaves
                        
                        push PosicaoAliada
                        mov FlagApagaAliada, 1                        
                        call desenhaAliadas 
                        mov FlagApagaAliada,0
                        pop PosicaoAliada

                    proximaNave:
                        inc si
                        add di, 2
                        pop cx
                        loop lacoVerificaColisaoAliadas
                        
                    
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax

        ret
        endp

        verificaColisaoNavesTodas proc
            push ax
            push bx
            push cx
            push dx
            push si

                mov cx, contNavesInimigas
                mov si, 0

                verifica_colisao_naves_loop:
                    cmp cx, 0
                    je fim_verifica_colisao_naves

                    ; Carrega a posição do inimigo atual
                    mov ax, [vetorPosicaoInimigos + si]
                    mov dx, [vetorFlagInimigos + si]
                    cmp dx, 0
                    je proximo_inimigo_colisao_naves
                    mov PosicaoInimiga, ax

                    ; Carrega o deslocamento do inimigo atual
                    mov ax, [vetorDeslocamentoInimigos + si]
                    mov DeslocamentoInimigo, ax

                    ; Verifica a colisão do inimigo atual com as naves aliadas
                    call verificaColisaoNaves

                    ; Atualiza o flag do inimigo no vetor
                    mov ax, FlagInimigo
                    mov [vetorFlagInimigos + si], ax

                proximo_inimigo_colisao_naves:
                    ; Incrementa o índice do vetor
                    add si, 2
                    loop verifica_colisao_naves_loop

                fim_verifica_colisao_naves:


            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp
        
        desenhaProximaAliada proc
            push ax
            push cx
            push dx
            push si

            mov cx, 8
            xor si, si
                lacoVerificaCorAliada:
                    mov al, [vetorCorNaves + si]
                    cmp al, 0
                    je proximaNaveCor
                        mov al, [vetorCorNaves + si]
                        mov CorAliada, al
                        mov CorAliadaAtual, al
                        call desenha_nave
                        jmp fimVerificaCorAliada

                    proximaNaveCor:
                        inc si
                        loop lacoVerificaCorAliada

            fimVerificaCorAliada:
            pop si
            pop dx
            pop cx
            pop ax
        ret
        endp
        
        numeroAleatorio proc
            push ax
            push bx
            push cx

                mov ah, 00h
                int 1Ah

                mov ax,dx
                xor dx, dx
                mov cx, 7 ;limitar para 7 o "range" da rotação do aleatorio
                div cx
                add dx, 1 
                mov RotacaoAleatorio, dl

                mov ah, 00h            
                int 1Ah    

                mov cl, RotacaoAleatorio
                rol dx, cl              ; Rotaciona bits em DX para a esquerda
                xor dx, ax             ; Mistura DX com o valor de AX 
                sub dx, 0FCF1h          ; Adiciona um número arbitrário para misturar ainda mais
                
                mov ax, dx             
                xor dx, dx             
                mov cx, rangeAleatorio             ; Definir (10 - 1 + 1) = 10 como o divisor
                div cx                 ; AX = AX / 10, DX = resto (valor mod 10)
                mov ax,dx
                add ax, deslocAleatorio              ; Adicionar 1 para ajustar a faixa para entre 1 e 10

                mov numAleatorio, ax

            pop cx
            pop bx
            pop ax
        ret
        endp

        movimentoInimigo proc
            push ax
            push bx
            push cx
            push dx
            push si

                mov FlagInimigo,1
                mov ax, DeslocamentoInimigo
                cmp ax, -77
                jle InimigoFinalTela

                mov ax, PosicaoInimiga
                call apaga_elemento

                cmp contDeslocamentoHorizontalInimigo,5
                je MovimentoVertical                
                inc contDeslocamentoHorizontalInimigo
                jmp AndarFrente

                InimigoFinalTela:
                    mov ax, PosicaoInimiga
                    call apaga_elemento

                    mov FlagInimigo,0
                    dec contNavesInimigasVivas
                    inc contNavesInimigasAtravessaram
                    jmp fimMovimentaInimigo

                MovimentoVertical:
                    mov contDeslocamentoHorizontalInimigo,0

                    mov rangeAleatorio,1095
                    mov deslocAleatorio,1
                    call numeroAleatorio
                    mov ax, numAleatorio

                    test ax, 1             ; Testa o bit menos significativo (se for 0, é par)
                    jz alteraCima          ; Se o bit 0 for zero, o número é par Sobe a nave
                    jmp alteraBaixo       ; Se não, é ímpar / desce a nave
                    alteraBaixo:
                        xor ax, ax
                        jmp comparacaoDirecao
                    alteraCima:
                        mov ax, 1
                    
                    comparacaoDirecao:
                        cmp DirecaoInimigo, 1    ; Testa o bit menos significativo (se for 0, é par)
                        je cima                 ; Se o bit 0 for zero, o número é par Sobe a nave
                        jmp baixo                 ; Se não, é ímpar / desce a nave
                        
                        cima:
                            cmp PosicaoInimigaLinha, 40
                            jle baixo
                            sub PosicaoInimiga, 1600
                            mov DirecaoInimigo, ax
                            sub PosicaoInimigaLinha, 5
                            jmp AndarFrente
                        baixo:
                            cmp PosicaoInimigaLinha, 150
                            jge cima
                            add PosicaoInimiga, 1600
                            mov DirecaoInimigo, ax
                            add PosicaoInimigaLinha, 5
                            jmp AndarFrente
                    
                AndarFrente:
                sub PosicaoInimiga, 5
                sub DeslocamentoInimigo,5
                mov  CorInimiga,9

                call desenha_nave_inimiga 

            fimMovimentaInimigo:

            pop si
            pop dx
            pop cx
            pop bx
            pop ax            
        ret
        endp

        movimentoTodosInimigos proc
            push ax
            push bx
            push cx
            push dx
            push si

            mov cx, contNavesInimigas
            mov si, 0

                movimento_inimigos_loop:
                        cmp cx, 0
                        je fim_movimento_inimigos

                        ; Carrega a posição do inimigo atual

                        mov dx, [vetorFlagInimigos + si]
                        cmp dx, 0
                        je proximo_inimigo

                        MovimentaInimigo:
                            mov ax, [vetorPosicaoInimigos + si]
                            mov PosicaoInimiga, ax

                            ; Carrega o deslocamento do inimigo atual
                            mov ax, [vetorDeslocamentoInimigos + si]
                            mov DeslocamentoInimigo, ax

                            ; Carrega a direção do inimigo atual
                            mov ax, [vetorDirecaoInimigos + si]
                            mov DirecaoInimigo, ax
                            
                            mov ax, [vetorContDeslocamentoHorizontalInimigo + si]
                            mov contDeslocamentoHorizontalInimigo, ax

                            ; Move o inimigo
                            call movimentoInimigo

                            ; Atualiza a posição do inimigo no vetor
                            mov ax, PosicaoInimiga
                            mov [vetorPosicaoInimigos + si], ax

                            ; Atualiza o deslocamento do inimigo no vetor
                            mov ax, DeslocamentoInimigo
                            mov [vetorDeslocamentoInimigos + si], ax
                            
                            mov ax, contDeslocamentoHorizontalInimigo
                            mov [vetorContDeslocamentoHorizontalInimigo + si], ax
                            
                            mov ax, DirecaoInimigo
                            mov [vetorDirecaoInimigos + si], ax

                            mov ax, PosicaoInimigaLinha
                            mov [vetorPosicaoInimigaLinha + si], ax

                            ; Atualiza o flag do inimigo no vetor
                            mov ax, FlagInimigo
                            mov [vetorFlagInimigos + si], ax

                    proximo_inimigo:
                        ; Incrementa o índice do vetor
                        add si, 2
                        loop movimento_inimigos_loop

                    fim_movimento_inimigos:

            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp
        
        clearBuffer proc
            push ax
                xor ax,ax
                clearBufferTeclado:
                    mov ah, 01h
                    int 16h
                    jz BufferLimpo

                    mov ah, 00h; remove tecla do buffer
                    int 16h          
                    jmp clearBufferTeclado  

                    BufferLimpo:
            pop ax
        ret
        endp

        lacoPrincipal proc
                ;inicia o timer
                xor ax,ax
                mov al, TempoSetor
                mov Timer, al

                call limpaTela
                call desenhaStatus
                call desenhaTerreno
                call desenhaAliadas

                mov  CorAliada,15            
                xor ax,ax
                mov  ax, PosicaoAliadaInicial
                mov  PosicaoAliada, ax
                call desenha_nave 

                inc contNavesInimigas
                call desenhaInimigas

            LACOPRINCIPAL1:       
                call musicaMenu     
                call movimentaAliada
                call clearBuffer
                call movimentaTiro

                xor ax,ax
                mov ax, FlagInimigo
                cmp ax, 0
                jne pulaDesenharAleatoriaInimigo

                    inc FlagInimigo
                    call desenhaAleatoriaInimiga
                    
                pulaDesenharAleatoriaInimigo:

                    call movimentoTodosInimigos
                    call verificaColisaoTiroTodas
                    call verificaColisaoNavesTodas

                    push PosicaoAliada
                    mov FlagApagaAliada, 0
                    call desenhaAliadas
                    pop PosicaoAliada

                    call movimentaTerreno

                    mov cx, DelayMovimentoH
                    mov dx, DelayMovimentoL
                    call delay

                    mov al, ContTimer
                    cmp al, DivTimer                    
                    jne NDecTimer
                        dec Timer
                        mov ContTimer, 0
                        jmp segueTimer

                    
                    NDecTimer:
                        inc ContTimer

                        inc contTimerInimigo
                        mov al, contTimerInimigo
                        cmp al, contTimerInimigoLimite
                        jne segueTimer
                            xor al, al
                            mov al, contNavesInimigasVivas
                            cmp al, maxNavesInimigas
                            ja segueTimer                            
                                inc contNavesInimigas
                                call desenhaInimigas
                                mov contTimerInimigo, 0

                    segueTimer:
                        mov al, Timer
                        cmp al, 0
                        jne continuaTimer

                        call calculoSetor

                        cmp setorAtual, 3
                        je FimDeJogo

                            inc setorAtual
                            call limpaTela
                            call telaSetor
                            mov al, TempoSetor
                            mov Timer, al

                            call limpaTela
                            call desenhaTerreno

                            ; Desenha a nave aliada na posição inicial
                            mov ax, PosicaoAliadaInicial
                            mov PosicaoAliada, ax
                            mov al, CorAliadaAtual
                            mov CorAliada, al
                            call desenha_nave

                            jmp continuaTimer

                        FimDeJogo:
                            call Vencedor

                    continuaTimer:    
                    call desenhaStatus

                jmp LACOPRINCIPAL1
        ret
        endp
        
        calculoSetor proc
            push ax
            push bx
            push cx
            push dx

                cmp setorAtual, 1
                    je AjustePontosSetor1
                cmp setorAtual, 2
                    je AjustePontosSetor2
                cmp setorAtual, 3
                    je AjustePontosSetor3

                AjustePontosSetor1:                     
                    xor ax, ax
                    mov ax, 10
                    xor bx, bx
                    mov bx, contNavesInimigasAtravessaram
                    mul bx
                    sub Score, ax

                    xor ax, ax
                    mov ax, 1000
                    xor bx, bx  
                    mov bx, contNaves
                    mul bx
                    add Score, ax
                    jmp SegueOJogo
                AjustePontosSetor2:
                    xor ax, ax
                    mov ax, 20
                    xor bx, bx
                    mov bx, contNavesInimigasAtravessaram
                    mul bx
                    sub Score, ax
                    
                    xor ax, ax
                    mov ax, 2000
                    xor bx, bx
                    mov bx, contNaves
                    mul bx
                    add Score, ax
                    jmp SegueOJogo
                AjustePontosSetor3: 
                    xor ax, ax
                    mov ax,30
                    xor bx, bx
                    mov bx, contNavesInimigasAtravessaram
                    mul bx
                    sub Score, ax
                    jmp SegueOJogo
                
                SegueOJogo:
                mov contNavesInimigasAtravessaram, 0

            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        telaSetor proc
            push ax
            push bx
            push cx
            push dx
            push si
            push ES

                mov ax, PosicaoTiro
                call apaga_elemento

                mov FlagTiro, 0
                mov DeslocamentoTiro, 0

                call resetaInimigos
                mov contNavesInimigasVivas, 0

                mov AX, DS      
                mov ES, AX

                cmp setorAtual, 1
                je Setor1
                cmp setorAtual, 2
                je Setor2
                cmp setorAtual, 3
                je Setor3

                Setor1:  
                    XOR si,si
                    MOV SI, offset TituloSetor1
                    XOR BX, BX    
                    mov bl, CorTituloSetor1
                    mov maxNavesInimigas, 10
                    mov velocidadeMusicaMenu,4

                    mov contTimerInimigoLimite, 40 ; 1 inimigo por segundo 

                    push ax
                    push si                    
                        mov al, CorTituloSetor1
                        mov CorRemap, al
                        mov si, offset SpriteTerreno
                        call remapeia_cor_terreno
                    pop si
                    pop ax

                jmp SetorFim
                
                Setor2:  
                    XOR si,si
                    MOV SI, offset TituloSetor2
                    XOR BX, BX    
                    mov bl, CorTituloSetor2
                    mov maxNavesInimigas, 15
                    mov velocidadeMusicaMenu,3

                    mov contTimerInimigoLimite, 30 ; 1,5 inimigo por segundo 

                    push ax
                    push si                    
                        mov al, CorTituloSetor2
                        mov CorRemap, al
                        mov si, offset SpriteTerreno
                        call remapeia_cor_terreno
                    pop si
                    pop ax

                jmp SetorFim
                
                Setor3:  
                    XOR si,si
                    MOV SI, offset TituloSetor3
                    XOR BX, BX    
                    mov bl, CorTituloSetor3
                    mov maxNavesInimigas, 20
                    mov velocidadeMusicaMenu,2

                    mov contTimerInimigoLimite, 20 ; 20 inimigo por segundo 

                    push ax
                    push si                    
                        mov al, CorTituloSetor3
                        mov CorRemap, al
                        mov si, offset SpriteTerreno
                        call remapeia_cor_terreno
                    pop si
                    pop ax

                jmp SetorFim            

                SetorFim:
                    mov DL, 0
                    mov DH, 10
                    mov CX, 200  

                    call escreveTexto

            pop ES
            
            call musicaSetor
            call stop_sound

            mov CX, DelaySetorH
            mov DX, DelaySetorL
            call delay

            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        musicaSetor proc
            push ax
            push bx
            push cx
            push dx
            push si         

                mov cx, tamanhoMusicaSetor

                xor si, si
                MusicaSetor:
                    mov bx, [vetorMusicaSetor + si]
                    call play_sound
                    mov dx, 40000
                    
                    push cx
                    mov cx, 6
                    delaySomSetorLoop:
                        call delay_som
                        loop delaySomSetorLoop
                    pop cx            
                            
                    call stop_sound

                    add si, 2
                    sub cx,2
                jnz MusicaSetor

                call stop_sound
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp
        
        desenhaOpcoes proc
                push ax
                push bx
                push cx
                push dx 
                push si
                push bp
                push es

                mov AX, DS        
                mov ES, AX

                MOV SI, offset textoJogar
                mov DH,197
                mov DL,199
                mov CX, tamanhoTextoJogar
                XOR BX, BX 

                MOV BL, corJogar            
                call escreveTexto

                MOV SI, offset textoSair
                mov DH,200
                mov DL,199
                mov CX, tamanhoTextoSair
                XOR BX, BX
                MOV BL, corSair      
                call escreveTexto

                pop es
                pop bp
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
        ret
        endp

        limpaTela proc

            push AX
            push BX
            push CX 

                mov cx,200
                xor bx,bx
                lACOAPAGATELA:
                    push cx
                        xor ax,ax
                        xor di,di   
                        mov di,bx
                        mov cx,320    
                        cld         
                        rep stosw   
                        add bx,320
                    pop cx
                    loop lACOAPAGATELA

            pop CX
            pop BX
            pop AX 
            
        ret
        endp

        somClique proc
            push bx
            push dx

                mov bx, 2200          ; Frequência
                call play_sound
                mov dx, 40000          ; Duração do som
                call delay_som
                call stop_sound

            pop dx
            pop bx
        ret
        endp
        
        musicaMenu proc
            push ax
            push bx
            push si

                mov al, velocidadeMusicaMenu
                cmp contadorMusicaMenu, al
                jne segueMusica
                    mov contadorMusicaMenu, 0

                    mov ax, tamanhoMusicaMenu
                    sub ax, 2
                    cmp notaMusicaMenu, ax
                    jge zeranotaMusicaMenu
                        add notaMusicaMenu,2
                        jmp paraNota
                    zeranotaMusicaMenu:
                        mov notaMusicaMenu, 0
                    
                    paraNota:
                    call stop_sound
                    jmp FimMusicaMenu

                segueMusica:
                inc contadorMusicaMenu

                mov si, notaMusicaMenu
                mov bx, [vetorMusicaMenu + si]
                call play_sound
                jmp FimMusicaMenu

            FimMusicaMenu:

            pop si
            pop bx
            pop ax
        ret
        endp

        identificaCliqueMenu proc            
            push ax        
                
                mov al, 0            
                mov ah, 01h
                int 16h
                jz semClique  ;sem input, ignorar
                
                call stop_sound
                call somClique
                
                mov ax, 0h 
                int 16h    ;pega o caracter do buffer

                cmp ah, 48h
                je clique
                cmp ah, 50h
                je clique   
                cmp al, 0Dh     
                je cliqueEnter  

                jmp semClique 
                
                clique:
                    mov al, Jogar
                    cmp al, 1
                    je desenhaOpcoesJMP
                    
                    mov Jogar, 1
                    mov corJogar, 12
                    mov corSair, 15
                    call desenhaOpcoes
                    jmp semClique

                    desenhaOpcoesJMP:
                    mov Jogar, 0
                    mov corJogar, 15
                    mov corSair, 12
                    call desenhaOpcoes
                    jmp semClique
                
                cliqueEnter:                
                    call limpaTela

                    mov al, Jogar
                    cmp al, 1
                    je entrarJogo
                    
                    mov AH, 4CH
                    int 21H

                    entrarJogo:
                    mov Jogar, 0
                    mov Jogando, 1
                    
                semClique:

            pop ax
        ret
        endp
        
        tela_inicio proc
            call writeTitulo
            call desenhaOpcoes

            CICLO:     


                mov  CorAliada,15
                mov  PosicaoAliada, 31680
                call desenha_nave        

                mov  CorInimiga,9
                mov  PosicaoInimiga,35505
                call desenha_nave_inimiga    
                
                xor cx,cx
                mov cx, 156
                    NAVEALIADA:   
                        ;call apaga_nave

                        mov ax, PosicaoAliada
                        call apaga_elemento

                        add PosicaoAliada, 2
                        mov  CorAliada,15
                        call desenha_nave 
                        call identificaCliqueMenu
                        call clearBuffer

                        push ax
                            mov al, Jogando
                            cmp al, 1
                            je SAIRCICLO
                        pop ax
                        
                        push cx
                        push dx                    
                            mov CX, DelayMovimentoH
                            mov DX, DelayMovimentoL
                            call delay                    
                        pop dx
                        pop cx

                        call musicaMenu

                        loop NAVEALIADA

                        ;call apaga_nave     

                        mov ax, PosicaoAliada
                        call apaga_elemento

                        mov  CorAliada,15
                        mov  PosicaoAliada,31680
                        call desenha_nave

                xor cx,cx
                mov cx, 156
                    NAVEINIMIGA:   

                        ;call apaga_nave_inimiga
                        mov ax, PosicaoInimiga
                        call apaga_elemento

                        sub PosicaoInimiga, 2
                        mov  CorInimiga,9
                        call desenha_nave_inimiga 
                        call identificaCliqueMenu
                        call clearBuffer

                        ;push ax
                            mov al, Jogando
                            cmp al, 1
                            je SAIRCICLO
                        ;pop ax

                        push cx
                        push dx                    
                            mov CX, DelayMovimentoH
                            mov DX, DelayMovimentoL
                            call delay                    
                        pop dx
                        pop cx

                        call musicaMenu

                        loop NAVEINIMIGA

                        ;call apaga_nave_inimiga
                        mov ax, PosicaoInimiga
                        call apaga_elemento     

                        mov  CorInimiga,9
                        mov  PosicaoInimiga,35505
                        call desenha_nave_inimiga

                        

                jmp CICLO

                SAIRCICLO:
                    ;call limpaTela
                    call telaSetor
                    call lacoPrincipal
            ret
        endp
        
        write_tela proc
            call tela_inicio
            ret
        endp

        musicaGameOver proc
            push ax
            push bx
            push cx
            push dx
            push si         

                mov cx, tamanhoMusicaGameOver
                sub cx, 2
                xor si, si
                MusicaGameOver:
                    mov bx, [vetorMusicaGameOver + si]
                    call play_sound
                    mov dx, 40000
                    
                    push cx
                    mov cx, 10
                    delaySomLoop:
                        call delay_som
                        loop delaySomLoop
                    pop cx

                    call stop_sound

                    add si, 2
                    sub cx,2
                jnz MusicaGameOver

            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        GameOver proc
            call limpaTela
            push ES

            mov AX, DS        ; of data segment 
            mov ES, AX

            XOR si,si
            MOV SI, offset TextoGameOver1

            ;coluna
            mov DL, 0
            mov DH, 6
            mov CX, 200
            XOR BX, BX
            ;cor do texto
            MOV BL, 4
            
            call escreveTexto

            XOR si,si
            MOV SI, offset TextoGameOver2

            ;coluna
            mov DL, 0
            mov DH, 11
            mov CX, 160
            XOR BX, BX
            ;cor do texto
            MOV BL, 4
            
            call escreveTexto

            XOR si,si
            MOV SI, offset TextoGameOverTecla

            ;coluna
            mov DL, 9
            mov DH, 17
            mov CX, TamTextoGameOverTecla
            XOR BX, BX
            ;cor do texto
            MOV BL, 4
            
            call escreveTexto

            pop ES

            call musicaGameOver

            call clearBuffer

            semCliqueGameOver:
                mov al, 0            
                mov ah, 01h
                int 16h
                jz semCliqueGameOver  ;sem input, ignorar
                
            
            mov ah, 00h; remove tecla do buffer
            int 16h  

            mov CX, 01H
            mov DX, 0FFFFH
            call delay

            call reseta_todos_status
            call limpaTela
            call write_tela

        ret
        endp
        
        musicaVencedor proc
            push ax
            push bx
            push cx
            push dx
            push si         

                mov cx, tamanhoMusicaVencedor
                ;sub cx, 2
                xor si, si
                MusicaVencedor:
                    mov bx, [vetorMusicaVencedor + si]
                    call play_sound
                    mov dx, 40000
                    
                    push cx
                    mov cx, 7
                    delaySomVencedorLoop:
                        call delay_som
                        loop delaySomVencedorLoop
                    pop cx                    
                    call stop_sound

                    add si, 2
                    sub cx,2
                jnz MusicaVencedor

            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        ret
        endp

        Vencedor proc
            push ax 
            push bx
            push cx
            push dx
            push di
            push si

            push ES
                call limpaTela

                mov AX, DS        ; of data segment 
                mov ES, AX

                XOR si,si
                MOV SI, offset TextoVencedor
                ;coluna
                mov DL, 0
                mov DH, 6
                mov CX, TamTextoVencedor
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto

                MOV SI, offset textoScore
                ;coluna
                mov DL, 14
                mov DH, 14
                mov CX, 6
                XOR BX, BX
                ;cor do texto
                MOV BL, 15
                
                call escreveTexto
                
                mov AX, Score
                mov DI, offset ScoreSTR
                call ESC_UINT16
                
                MOV SI, offset ScoreSTR
                ;coluna
                mov DL, 20
                mov DH, 14
                mov CX, tamanhoScoreSTR
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto               


                XOR si,si
                MOV SI, offset TextoGameOverTecla

                ;coluna
                mov DL, 7
                mov DH, 17
                mov CX, TamTextoGameOverTecla
                XOR BX, BX
                ;cor do texto
                MOV BL, 10
                
                call escreveTexto

            pop ES

            call musicaVencedor

            mov CX, 0FH
            mov DX, 0FFFFH
            call delay
            
            ;limpaBuffer:
            ;    mov al, 0            
            ;    mov ah, 01h
            ;    int 16h
            ;    jz semCliqueVencedor

            ;    mov ah, 00h; remove tecla do buffer
            ;    int 16h          
            ;    jmp limpaBuffer    
            call clearBuffer 

                semCliqueVencedor:
                    mov al, 0            
                    mov ah, 01h
                    int 16h
                    jz semCliqueVencedor  ;sem input, ignorar
                    
                call clearBuffer
                
                mov ah, 00h; remove tecla do buffer
                int 16h  

                mov CX, 01H
                mov DX, 0FFFFH
                call delay

            pop si
            pop di
            pop dx
            pop cx
            pop bx
            pop ax 

                call reseta_todos_status
                call limpaTela
                call write_tela
            

        ret
        endp

        resetaInimigos proc
        
            push ax
            push bx
            push cx
            push dx
            push si
            
            ; Limpa todos os inimigos da tela
            mov cx, contNavesInimigas

            mov si, 0

            limpa_inimigos_loop:
                cmp cx, 0
                je fim_limpa_inimigos

                ; Carrega a posição do inimigo atual
                mov ax, [vetorPosicaoInimigos + si]
                mov dx, [vetorFlagInimigos + si]
                cmp dx, 0
                je proximo_inimigo_limpa
                mov PosicaoInimiga, ax

                ; Apaga o inimigo da tela
                ;call apaga_nave_inimiga
                mov ax, PosicaoInimiga
                call apaga_elemento

                ; Atualiza a posição do inimigo no vetor
                mov [vetorPosicaoInimigos + si], 0

                ; Atualiza o deslocamento do inimigo no vetor
                mov [vetorDeslocamentoInimigos + si], 0

                ; Atualiza a direção do inimigo no vetor
                mov [vetorDirecaoInimigos + si], 0

                ; Atualiza o flag do inimigo no vetor
                mov [vetorFlagInimigos + si], 0

                ; Atualiza a posição da linha do inimigo no vetor
                mov [vetorPosicaoInimigaLinha + si], 0          

            proximo_inimigo_limpa:
                ; Incrementa o índice do vetor
                add si, 2
                loop limpa_inimigos_loop

            fim_limpa_inimigos:

            ; Reseta todos os flags
            mov cx, contNavesInimigas
            mov si, 0

            reseta_flags_loop:
                cmp cx, 0
                je fim_reseta_flags

                ; Reseta o flag do inimigo no vetor
                mov [vetorFlagInimigos + si], 0

                ; Incrementa o índice do vetor
                add si, 2
                loop reseta_flags_loop

            fim_reseta_flags:

            ; Reseta o número de inimigos
            mov contNavesInimigas, 0
            mov contNavesInimigasVivas, 0


            pop si
            pop dx
            pop cx
            pop bx
            pop ax
        
        ret
        endp

        resetaAliadas proc
            push cx
            push si

            ; Limpa todas as naves aliadas da tela
            mov cx, 8
            xor si, si

            lacoLimpaAliadas:
                mov [vetorFlagNaves + si], 1
                mov al,[vetorCorOriginalNaves + si]
                mov [vetorCorNaves + si], al
                inc si
                loop lacoLimpaAliadas

            pop si
            pop cx
        ret
        endp

        reseta_todos_status proc
            push ax
            push cx
            push di

            mov ax, PosicaoTiro
            call apaga_elemento

            mov FlagTiro, 0
            mov DeslocamentoTiro, 0

            call resetaInimigos
            call resetaAliadas

            mov Jogar, 1
            mov Jogando, 0

            mov PosicaoAliadaInicial, 27247
            mov PosicaoAliada, 0
            mov PosicaoAliadaComparacao, 0
            mov PosicaoInimigaComparacao, 0
            mov FlagAliadaFrente, 0
            mov DeslocamentoTiro, 0
            mov PosicaoTiro, 0
            mov FlagTiro, 0
            mov FlagInimigo, 0
            mov DeslocamentoInimigo, 0
            mov PosicaoInimiga, 0
            mov PosicaoInimigaColuna, 0
            mov PosicaoInimigaLinha, 0
            mov CorInimiga, 9
            mov CorAliada, 15
            mov CorAliadaAtual, 15
            mov contNaves, 8
            mov contNavesInimigasAtravessaram, 0
            mov velocidadeMusicaMenu,4

            mov ColidiuAliada, 0
            mov setorAtual, 1

            mov cx, 5
            xor di, di

            lacoResetaScore:
                mov [Score + di], 0
                add di,2
                loop lacoResetaScore

            mov ScoreSTR, 0
            mov al, TempoSetor
            mov Timer, al
            mov ContTimer, 0
            mov al, CorTituloSetor1
            mov corTerreno, al

            pop di
            pop cx
            pop ax
        ret
        endp


    inicio: 
        ; Inicializando o segmento de dados 
        mov AX, @data     ; Initialize DS to address 
        mov DS, AX        ; of data segment 
        mov ES, AX

        MOV AX, 13H ;TROCA PARA MODO GRAFICO
        INT 10H
        
        call somClique
        call write_tela
        
                
        mov AH, 4CH
        int 21H
        
    end inicio    