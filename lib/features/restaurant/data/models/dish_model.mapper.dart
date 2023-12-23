// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dish_model.dart';

class DishModelMapper extends ClassMapperBase<DishModel> {
  DishModelMapper._();

  static DishModelMapper? _instance;
  static DishModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DishModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DishModel';

  static String _$name(DishModel v) => v.name;
  static const Field<DishModel, String> _f$name = Field('name', _$name);

  @override
  final Map<Symbol, Field<DishModel, dynamic>> fields = const {
    #name: _f$name,
  };

  static DishModel _instantiate(DecodingData data) {
    return DishModel(name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static DishModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DishModel>(map);
  }

  static DishModel fromJson(String json) {
    return ensureInitialized().decodeJson<DishModel>(json);
  }
}

mixin DishModelMappable {
  String toJson() {
    return DishModelMapper.ensureInitialized()
        .encodeJson<DishModel>(this as DishModel);
  }

  Map<String, dynamic> toMap() {
    return DishModelMapper.ensureInitialized()
        .encodeMap<DishModel>(this as DishModel);
  }

  DishModelCopyWith<DishModel, DishModel, DishModel> get copyWith =>
      _DishModelCopyWithImpl(this as DishModel, $identity, $identity);
  @override
  String toString() {
    return DishModelMapper.ensureInitialized()
        .stringifyValue(this as DishModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DishModelMapper.ensureInitialized()
                .isValueEqual(this as DishModel, other));
  }

  @override
  int get hashCode {
    return DishModelMapper.ensureInitialized().hashValue(this as DishModel);
  }
}

extension DishModelValueCopy<$R, $Out> on ObjectCopyWith<$R, DishModel, $Out> {
  DishModelCopyWith<$R, DishModel, $Out> get $asDishModel =>
      $base.as((v, t, t2) => _DishModelCopyWithImpl(v, t, t2));
}

abstract class DishModelCopyWith<$R, $In extends DishModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name});
  DishModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DishModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DishModel, $Out>
    implements DishModelCopyWith<$R, DishModel, $Out> {
  _DishModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DishModel> $mapper =
      DishModelMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  DishModel $make(CopyWithData data) =>
      DishModel(name: data.get(#name, or: $value.name));

  @override
  DishModelCopyWith<$R2, DishModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DishModelCopyWithImpl($value, $cast, t);
}
