// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupStore on _SignupStoreBase, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_SignupStoreBase.nameValid'))
          .value;
  Computed<bool> _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_SignupStoreBase.emailValid'))
          .value;
  Computed<bool> _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_SignupStoreBase.phoneValid'))
          .value;
  Computed<bool> _$passwordValidComputed;

  @override
  bool get passwordValid =>
      (_$passwordValidComputed ??= Computed<bool>(() => super.passwordValid,
              name: '_SignupStoreBase.passwordValid'))
          .value;
  Computed<bool> _$passwordCopyValidComputed;

  @override
  bool get passwordCopyValid => (_$passwordCopyValidComputed ??= Computed<bool>(
          () => super.passwordCopyValid,
          name: '_SignupStoreBase.passwordCopyValid'))
      .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_SignupStoreBase.isFormValid'))
          .value;
  Computed<Function> _$signupButtonPressedComputed;

  @override
  Function get signupButtonPressed => (_$signupButtonPressedComputed ??=
          Computed<Function>(() => super.signupButtonPressed,
              name: '_SignupStoreBase.signupButtonPressed'))
      .value;

  final _$nameAtom = Atom(name: '_SignupStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_SignupStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$phoneAtom = Atom(name: '_SignupStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$passwordAtom = Atom(name: '_SignupStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$passwordCopyAtom = Atom(name: '_SignupStoreBase.passwordCopy');

  @override
  String get passwordCopy {
    _$passwordCopyAtom.reportRead();
    return super.passwordCopy;
  }

  @override
  set passwordCopy(String value) {
    _$passwordCopyAtom.reportWrite(value, super.passwordCopy, () {
      super.passwordCopy = value;
    });
  }

  final _$loadingAtom = Atom(name: '_SignupStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_SignupStoreBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$showErrorBoxAtom = Atom(name: '_SignupStoreBase.showErrorBox');

  @override
  bool get showErrorBox {
    _$showErrorBoxAtom.reportRead();
    return super.showErrorBox;
  }

  @override
  set showErrorBox(bool value) {
    _$showErrorBoxAtom.reportWrite(value, super.showErrorBox, () {
      super.showErrorBox = value;
    });
  }

  final _$_SignupStoreBaseActionController =
      ActionController(name: '_SignupStoreBase');

  @override
  void setName(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordCopy(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setPasswordCopy');
    try {
      return super.setPasswordCopy(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowError(bool value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setShowError');
    try {
      return super.setShowError(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
phone: ${phone},
password: ${password},
passwordCopy: ${passwordCopy},
loading: ${loading},
error: ${error},
showErrorBox: ${showErrorBox},
nameValid: ${nameValid},
emailValid: ${emailValid},
phoneValid: ${phoneValid},
passwordValid: ${passwordValid},
passwordCopyValid: ${passwordCopyValid},
isFormValid: ${isFormValid},
signupButtonPressed: ${signupButtonPressed}
    ''';
  }
}
