// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'menu_model.dart';

class MenuModelMapper extends ClassMapperBase<MenuModel> {
  MenuModelMapper._();

  static MenuModelMapper? _instance;
  static MenuModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MenuModelMapper._());
      DishModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MenuModel';

  static const Field<MenuModel, List<DishModel>> _f$foods =
      Field('foods', null, mode: FieldMode.param);
  static const Field<MenuModel, List<DishModel>> _f$drinks =
      Field('drinks', null, mode: FieldMode.param);

  @override
  final Map<Symbol, Field<MenuModel, dynamic>> fields = const {
    #foods: _f$foods,
    #drinks: _f$drinks,
  };

  static MenuModel _instantiate(DecodingData data) {
    return MenuModel(foods: data.dec(_f$foods), drinks: data.dec(_f$drinks));
  }

  @override
  final Function instantiate = _instantiate;

  static MenuModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MenuModel>(map);
  }

  static MenuModel fromJson(String json) {
    return ensureInitialized().decodeJson<MenuModel>(json);
  }
}

mixin MenuModelMappable {
  String toJson() {
    return MenuModelMapper.ensureInitialized()
        .encodeJson<MenuModel>(this as MenuModel);
  }

  Map<String, dynamic> toMap() {
    return MenuModelMapper.ensureInitialized()
        .encodeMap<MenuModel>(this as MenuModel);
  }

  MenuModelCopyWith<MenuModel, MenuModel, MenuModel> get copyWith =>
      _MenuModelCopyWithImpl(this as MenuModel, $identity, $identity);
  @override
  String toString() {
    return MenuModelMapper.ensureInitialized()
        .stringifyValue(this as MenuModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MenuModelMapper.ensureInitialized()
                .isValueEqual(this as MenuModel, other));
  }

  @override
  int get hashCode {
    return MenuModelMapper.ensureInitialized().hashValue(this as MenuModel);
  }
}

extension MenuModelValueCopy<$R, $Out> on ObjectCopyWith<$R, MenuModel, $Out> {
  MenuModelCopyWith<$R, MenuModel, $Out> get $asMenuModel =>
      $base.as((v, t, t2) => _MenuModelCopyWithImpl(v, t, t2));
}

abstract class MenuModelCopyWith<$R, $In extends MenuModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({required List<DishModel> foods, required List<DishModel> drinks});
  MenuModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MenuModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MenuModel, $Out>
    implements MenuModelCopyWith<$R, MenuModel, $Out> {
  _MenuModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MenuModel> $mapper =
      MenuModelMapper.ensureInitialized();
  @override
  $R call({required List<DishModel> foods, required List<DishModel> drinks}) =>
      $apply(FieldCopyWithData({#foods: foods, #drinks: drinks}));
  @override
  MenuModel $make(CopyWithData data) =>
      MenuModel(foods: data.get(#foods), drinks: data.get(#drinks));

  @override
  MenuModelCopyWith<$R2, MenuModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MenuModelCopyWithImpl($value, $cast, t);
}
