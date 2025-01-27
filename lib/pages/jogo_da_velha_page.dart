import 'package:flutter/material.dart';
import '../models/modelo_jogo.dart';

class JogoDaVelhaPage extends StatefulWidget {
  final String modo;

  const JogoDaVelhaPage({super.key, required this.modo});

  @override
  _JogoDaVelhaPageState createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  late ModeloJogo _modeloJogo;

  @override
  void initState() {
    super.initState();
    _modeloJogo = ModeloJogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'XoxO',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Placar',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'X: ${_modeloJogo.vitoriasX}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'O: ${_modeloJogo.vitoriasO}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SizedBox(
                width: 300,
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: _modeloJogo.tabuleiro.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        _modeloJogo.jogar(index, widget.modo);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            _modeloJogo.tabuleiro[index],
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: _modeloJogo
                                  .corJogador(_modeloJogo.tabuleiro[index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _modeloJogo.vencedor.isEmpty
                  ? 'Vez do jogador: ${_modeloJogo.jogadorAtual}'
                  : _modeloJogo.mensagemFimDeJogo,
              style: TextStyle(
                fontSize: 20,
                color: _modeloJogo.corJogador(_modeloJogo.vencedor),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {
                _modeloJogo.reiniciar();
              }),
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
