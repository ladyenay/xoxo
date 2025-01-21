import 'package:flutter_test/flutter_test.dart';
import 'package:xoxo/main.dart'; // Ajuste para o caminho correto do seu arquivo principal.

void main() {
  testWidgets('Verifica se o título do app aparece na tela',
      (WidgetTester tester) async {
    // Constrói o app e dispara um quadro.
    await tester
        .pumpWidget(const XoxOGame()); // Ajuste para o widget raiz do seu app.

    // Verifica se o título "XoxO" está sendo exibido.
    expect(find.text('XoxO'), findsOneWidget);
  });

  testWidgets('Verifica a interação com o botão Reiniciar',
      (WidgetTester tester) async {
    // Constrói o app.
    await tester.pumpWidget(const XoxOGame());

    // Verifica se o botão "Reiniciar" está presente.
    expect(find.text('Reiniciar'), findsOneWidget);

    // Simula o clique no botão "Reiniciar".
    await tester.tap(find.text('Reiniciar'));
    await tester.pump();

    // Verifica se o estado esperado do app mudou (ajuste conforme a lógica do seu app).
    expect(find.text('Jogador X venceu!'), findsNothing);
  });
}
