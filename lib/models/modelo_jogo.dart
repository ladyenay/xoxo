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
  bool _vezDaMaquina = false; // Controla a vez da máquina

  final Random random = Random();

  // Função principal para registrar uma jogada
  void jogar(int posicao, String modo) {
    if (_vezDaMaquina) return; // Bloqueia o jogador durante a jogada da máquina

    if (vencedor.isEmpty && tabuleiro[posicao].isEmpty) {
      tabuleiro[posicao] = jogadorAtual;
      rodadas++;
      verificarVencedor();

      // Alterna jogador ou aciona a máquina se o modo for PvM
      if (vencedor.isEmpty) {
        alternarJogador();
        if (modo == 'PvM' && jogadorAtual == 'O') {
          _vezDaMaquina = true; // Bloqueia o jogador enquanto a máquina joga
           {
            jogadaMaquina();
          }
        }
      }
    }
  }

  // Jogada da máquina
  void jogadaMaquina() {
    if (vencedor.isEmpty && rodadas < 9) {
      int posicao;
      do {
        posicao = escolherMelhorMovimento();
      } while (tabuleiro[posicao].isNotEmpty);

      tabuleiro[posicao] = 'O';
      rodadas++;
      verificarVencedor();
      _vezDaMaquina = false; // Libera o jogador após a jogada da máquina

      if (vencedor.isEmpty) {
        alternarJogador();
      }
    }
  }

  // Lógica para escolher a posição da máquina
  int escolherMelhorMovimento() {
    // Priorizar vitória da máquina
    for (int i = 0; i < 9; i++) {
      if (tabuleiro[i].isEmpty) {
        tabuleiro[i] = 'O';
        if (verificarVencedorInterno('O') != '') {
          tabuleiro[i] = '';
          return i; // Retorna a posição que garante a vitória
        }
        tabuleiro[i] = '';
      }
    }

    // Bloquear vitória do jogador
    for (int i = 0; i < 9; i++) {
      if (tabuleiro[i].isEmpty) {
        tabuleiro[i] = 'X';
        if (verificarVencedorInterno('X') != '') {
          tabuleiro[i] = '';
          return i; // Retorna a posição que bloqueia o jogador
        }
        tabuleiro[i] = '';
      }
    }

    // Estratégia para ocupar posições centrais ou estratégicas
    const posicoesPrioritarias = [4, 0, 2, 6, 8, 1, 3, 5, 7];
    for (int posicao in posicoesPrioritarias) {
      if (tabuleiro[posicao].isEmpty) {
        return posicao; // Escolhe uma posição prioritária disponível
      }
    }

    // Caso todas as outras opções falhem (improvável)
    return random.nextInt(9);
  }

  // Verifica se um jogador venceu (internamente, usado para lógica)
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

  // Alterna entre os jogadores
  void alternarJogador() {
    jogadorAtual = jogadorAtual == 'X' ? 'O' : 'X';
  }

  // Verifica se alguém venceu ou se houve empate
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

  // Reinicia o jogo
  void reiniciar() {
    tabuleiro = ['', '', '', '', '', '', '', '', ''];
    vencedor = '';
    rodadas = 0;
    jogadorAtual = 'X';
    mensagemFimDeJogo = '';
    _vezDaMaquina = false; // Garante que o jogador possa começar novamente
  }

  // Define as cores para os jogadores
  Color corJogador(String jogador) {
    if (jogador == 'X') return Colors.blue;
    if (jogador == 'O') return Colors.red;
    return Colors.black;
  }
}
