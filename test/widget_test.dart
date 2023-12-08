import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/auth/common/form_button.dart';

void main() {
  group("Form Button Test", () {
    testWidgets("Enabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(disabled: false),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
    });
  });
}
