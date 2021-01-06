// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterStore, Store {
  final _$orderByAtom = Atom(name: '_FilterStore.orderBy');

  @override
  OrderBy get orderBy {
    _$orderByAtom.reportRead();
    return super.orderBy;
  }

  @override
  set orderBy(OrderBy value) {
    _$orderByAtom.reportWrite(value, super.orderBy, () {
      super.orderBy = value;
    });
  }

  final _$orderByTypeAtom = Atom(name: '_FilterStore.orderByType');

  @override
  OrderByTypeStore get orderByType {
    _$orderByTypeAtom.reportRead();
    return super.orderByType;
  }

  @override
  set orderByType(OrderByTypeStore value) {
    _$orderByTypeAtom.reportWrite(value, super.orderByType, () {
      super.orderByType = value;
    });
  }

  final _$_FilterStoreActionController = ActionController(name: '_FilterStore');

  @override
  void setOrderBy(OrderBy value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setOrderBy');
    try {
      return super.setOrderBy(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderByType(OrderByTypeStore value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setOrderByType');
    try {
      return super.setOrderByType(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBy: ${orderBy},
orderByType: ${orderByType}
    ''';
  }
}
