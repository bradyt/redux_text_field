# redux_text_field

[![Build Status](https://travis-ci.org/Albert221/redux_text_field.svg?branch=master)](https://travis-ci.org/Albert221/redux_text_field)

`redux_text_field` is a library created to help people with creating forms and inputs that store their value in a Redux store.

## Usage

```dart
final reduxTextField = ReduxTextField(
  store: store,
  converter: (state) => state,
  action: _TestFieldUpdatedAction(),
);
```

`ReduxTextField` is a simple statefull widget that has a `TextField` under the hood. It gets all of the params of `TextField` except the `controller`, which this widget uses itself.

You pass your Redux `Store` to the `store` argument, a `converter` that is a function that takes state from your store as an argument and should return the value of your field and an `action`, that is a class implementing the `TextFieldUpdatedAction` abstract class. This action is being dispatched on all `TextField` value changes that are made.

If you make a change to your store changing the value of your field (that is changing the value returned by your `converter`), the value will be persisted to the `TextField` as well, making the `ReduxTextField` communication bidirectional.

[For a full example, head to the tests.](https://github.com/Albert221/redux_text_field/blob/master/test/redux_text_field_test.dart)