import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_ui_event.freezed.dart';

@freezed
class LoginUiEvent with _$LoginUiEvent {
  const factory LoginUiEvent.start({String? email}) = Start;
  const factory LoginUiEvent.showSnackBar(String message) = ShowSnackBar;
}
