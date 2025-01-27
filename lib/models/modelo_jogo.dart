import 'dart:math';
import 'package:flutter/material.dart';

class ModeloJogo {
  List<String> tabuleiro = ['', '', '', '', '', '', '', '', ''];
  String jogadorAtual = 'X';
  String vencedor = '';
  int rodadas = 0;
  String mensagemFimDeJogo = '';
  int vitoriasX = 0;
  int vitoriasO = 0;
  bool _vezDaMaquina = false;

  final Random random = Random();

  void jogar(int posicao, String modo) {
    if (_vezDaMaquina) return; 

    if (vencedor.isEmpty && tabuleiro[posicao].isEmpty) {
      tabuleiro[posicao] = jogadorAtual;
      rodadas++;
      verificarVencedor();

    
      if (vencedor.isEmpty) {
        alternarJogador();
        if (modo == 'PvM' && jogadorAtual == 'O') {
          _vezDaMaquina = true;
           {
            jogadaMaquina();
          }
        }
      }
    }
  }

  void jogadaMaquina() {
    if (vencedor.isEmpty && rodadas < 9) {
      int posicao;
      do {
        posicao = escolherMelhorMovimento();
      } while (tabuleiro[posicao].isNotEmpty);

      tabuleiro[posicao] = 'O';
      rodadas++;
      verificarVencedor();
      _vezDaMaquina = false; 

      if (vencedor.isEmpty) {
        alternarJogador();
      }
    }
  }


  int escolherMelhorMovimento() {

    for (int i = 0; i < 9; i++) {
      if (tabuleiro[i].isEmpty) {
        tabuleiro[i] = 'O';
        if (verificarVencedorInterno('O') != '') {
          tabuleiro[i] = '';
          return i;
        }
        tabuleiro[i] = '';
      }
    }


    for (int i = 0; i < 9; i++) {
      if (tabuleiro[i].isEmpty) {
        tabuleiro[i] = 'X';
        if (verificarVencedorInterno('X') != '') {
          tabuleiro[i] = '';
          return i;
        }
        tabuleiro[i] = '';
      }
    }
    const posicoesPrioritarias = [4, 0, 2, 6, 8, 1, 3, 5, 7];
    for (int posicao in posicoesPrioritarias) {
      if (tabuleiro[posicao].isEmpty) {
        return posicao; 
      }
    }

    return random.nextInt(9);
  }

  String verificarVencedorInterno(String jogador) {
    const combinacoesVitoriosas = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combinacao in combinacoesVitoriosas) {
      if (tabuleiro[combinacao[0]] == jogador &&
          tabuleiro[combinacao[1]] == jogador &&
          tabuleiro[combinacao[2]] == jogador) {
        return jogador;
      }
    }
    return '';
  }


  void alternarJogador() {
    jogadorAtual = jogadorAtual == 'X' ? 'O' : 'X';
  }


  void verificarVencedor() {
    const combinacoesVitoriosas = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combinacao in combinacoesVitoriosas) {
      if (tabuleiro[combinacao[0]] == tabuleiro[combinacao[1]] &&
          tabuleiro[combinacao[1]] == tabuleiro[combinacao[2]] &&
          tabuleiro[combinacao[0]].isNotEmpty) {
        vencedor = tabuleiro[combinacao[0]];
        if (vencedor == 'X') {
          vitoriasX++;
        } else if (vencedor == 'O') {
          vitoriasO++;
        }
        mensagemFimDeJogo = 'Vencedor: $vencedor';
        return;
      }
    }

    if (rodadas == 9 && vencedor.isEmpty) {
      vencedor = 'Empate!';
      mensagemFimDeJogo = 'Empate!';
    }
  }


  void reiniciar() {
    tabuleiro = ['', '', '', '', '', '', '', '', ''];
    vencedor = '';
    rodadas = 0;
    jogadorAtual = 'X';
    mensagemFimDeJogo = '';
    _vezDaMaquina = false; 
  }


  Color corJogador(String jogador) {
    if (jogador == 'X') return Colors.blue;
    if (jogador == 'O') return Colors.red;
    return Colors.black;
  }
}