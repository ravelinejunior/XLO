// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$searchAtom = Atom(name: '_HomeStore.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$categorySelectedAtom = Atom(name: '_HomeStore.categorySelected');

  @override
  Category get categorySelected {
    _$categorySelectedAtom.reportRead();
    return super.categorySelected;
  }

  @override
  set categorySelected(Category value) {
    _$categorySelectedAtom.reportWrite(value, super.categorySelected, () {
      super.categorySelected = value;
    });
  }

  final _$filterAtom = Atom(name: '_HomeStore.filter');

  @override
  FilterStore get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(FilterStore value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void setSearch(String text) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setSearch');
    try {
      return super.setSearch(text);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(Category value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(FilterStore value) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
categorySelected: ${categorySelected},
filter: ${filter}
    ''';
  }
}
