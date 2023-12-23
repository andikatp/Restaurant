// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'restaurant_model.dart';

class RestaurantModelMapper extends ClassMapperBase<RestaurantModel> {
  RestaurantModelMapper._();

  static RestaurantModelMapper? _instance;
  static RestaurantModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RestaurantModelMapper._());
      MenuModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RestaurantModel';

  static String _$id(RestaurantModel v) => v.id;
  static const Field<RestaurantModel, String> _f$id = Field('id', _$id);
  static String _$name(RestaurantModel v) => v.name;
  static const Field<RestaurantModel, String> _f$name = Field('name', _$name);
  static String _$description(RestaurantModel v) => v.description;
  static const Field<RestaurantModel, String> _f$description =
      Field('description', _$description);
  static String _$pictureId(RestaurantModel v) => v.pictureId;
  static const Field<RestaurantModel, String> _f$pictureId =
      Field('pictureId', _$pictureId);
  static String _$city(RestaurantModel v) => v.city;
  static const Field<RestaurantModel, String> _f$city = Field('city', _$city);
  static double _$rating(RestaurantModel v) => v.rating;
  static const Field<RestaurantModel, double> _f$rating =
      Field('rating', _$rating);
  static const Field<RestaurantModel, MenuModel> _f$menus =
      Field('menus', null, mode: FieldMode.param);

  @override
  final Map<Symbol, Field<RestaurantModel, dynamic>> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #pictureId: _f$pictureId,
    #city: _f$city,
    #rating: _f$rating,
    #menus: _f$menus,
  };

  static RestaurantModel _instantiate(DecodingData data) {
    return RestaurantModel(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        pictureId: data.dec(_f$pictureId),
        city: data.dec(_f$city),
        rating: data.dec(_f$rating),
        menus: data.dec(_f$menus));
  }

  @override
  final Function instantiate = _instantiate;

  static RestaurantModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RestaurantModel>(map);
  }

  static RestaurantModel fromJson(String json) {
    return ensureInitialized().decodeJson<RestaurantModel>(json);
  }
}

mixin RestaurantModelMappable {
  String toJson() {
    return RestaurantModelMapper.ensureInitialized()
        .encodeJson<RestaurantModel>(this as RestaurantModel);
  }

  Map<String, dynamic> toMap() {
    return RestaurantModelMapper.ensureInitialized()
        .encodeMap<RestaurantModel>(this as RestaurantModel);
  }

  RestaurantModelCopyWith<RestaurantModel, RestaurantModel, RestaurantModel>
      get copyWith => _RestaurantModelCopyWithImpl(
          this as RestaurantModel, $identity, $identity);
  @override
  String toString() {
    return RestaurantModelMapper.ensureInitialized()
        .stringifyValue(this as RestaurantModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RestaurantModelMapper.ensureInitialized()
                .isValueEqual(this as RestaurantModel, other));
  }

  @override
  int get hashCode {
    return RestaurantModelMapper.ensureInitialized()
        .hashValue(this as RestaurantModel);
  }
}

extension RestaurantModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RestaurantModel, $Out> {
  RestaurantModelCopyWith<$R, RestaurantModel, $Out> get $asRestaurantModel =>
      $base.as((v, t, t2) => _RestaurantModelCopyWithImpl(v, t, t2));
}

abstract class RestaurantModelCopyWith<$R, $In extends RestaurantModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? description,
      String? pictureId,
      String? city,
      double? rating,
      required MenuModel menus});
  RestaurantModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RestaurantModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RestaurantModel, $Out>
    implements RestaurantModelCopyWith<$R, RestaurantModel, $Out> {
  _RestaurantModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RestaurantModel> $mapper =
      RestaurantModelMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? description,
          String? pictureId,
          String? city,
          double? rating,
          required MenuModel menus}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (pictureId != null) #pictureId: pictureId,
        if (city != null) #city: city,
        if (rating != null) #rating: rating,
        #menus: menus
      }));
  @override
  RestaurantModel $make(CopyWithData data) => RestaurantModel(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      pictureId: data.get(#pictureId, or: $value.pictureId),
      city: data.get(#city, or: $value.city),
      rating: data.get(#rating, or: $value.rating),
      menus: data.get(#menus));

  @override
  RestaurantModelCopyWith<$R2, RestaurantModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RestaurantModelCopyWithImpl($value, $cast, t);
}
