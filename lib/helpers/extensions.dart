extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return regExp.hasMatch(this);
  }
}
