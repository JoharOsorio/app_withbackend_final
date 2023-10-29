import 'package:app_withbackend_final/theme/theme.dart';

class InputDecortions {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: MyTheme.primary,
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: MyTheme.primary,
          width: 3,
        )),
        hintText: hinText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyTheme.primary,
              )
            : null);
  }
}
