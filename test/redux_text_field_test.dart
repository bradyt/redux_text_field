import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'package:redux_text_field/redux_text_field.dart';

void main() {
  testWidgets('ReduxTextField communicates with store bidirectionally',
      (WidgetTester tester) async {
    final store = Store<String>(_rootReducer, initialState: '');

    final reduxTextField = ReduxTextField(
      store: store,
      converter: (state) => state,
      action: _TestFieldUpdatedAction(),
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: reduxTextField)));

    expect(store.state, '');

    await tester.enterText(find.byType(TextField), 'hello');

    expect(store.state, 'hello');
    expect(find.text('hello'), findsOneWidget);

    store.dispatch(_TestFieldUpdatedAction()..setNewValue('goodbye'));

    // wait for async stuff to be done
    await tester.pump(Duration(milliseconds: 10));

    expect(store.state, 'goodbye');
    expect(find.text('goodbye'), findsOneWidget);
  });
}

String _rootReducer(String state, dynamic action) {
  if (action is _TestFieldUpdatedAction) {
    return action.value;
  }

  return state;
}

class _TestFieldUpdatedAction implements TextFieldUpdatedAction {
  String value;

  @override
  void setNewValue(String newValue) {
    value = newValue;
  }
}
