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

  final Random random = Random();

  void jogar(int posicao, String modo) {
    if (vencedor.isEmpty && tabuleiro[posicao].isEmpty) {
      tabuleiro[posicao] = jogadorAtual;
      rodadas++;
      verificarVencedor();

      if (modo == 'PvM' && jogadorAtual == 'X' && vencedor.isEmpty) {
        {
          jogadaMaquina();
        }
      } else {
        alternarJogador();
      }
    }
  }

  void jogadaMaquina() {
    if (vencedor.isEmpty && rodadas < 9) {
      int posicao;
      do {
        posicao = random.nextInt(9); // Escolhe uma posição aleatória
      } while (
          tabuleiro[posicao].isNotEmpty); // Garante que a posição esteja vazia

      tabuleiro[posicao] = 'O'; // A máquina joga com 'O'
      rodadas++;
      verificarVencedor();
    }
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
  }

  Color corJogador(String jogador) {
    if (jogador == 'X') return Colors.blue;
    if (jogador == 'O') return Colors.red;
    return Colors.black;
  }
}
