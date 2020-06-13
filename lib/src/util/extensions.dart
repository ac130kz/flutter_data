part of flutter_data;

// enums

// ignore: constant_identifier_names
enum DataRequestMethod { GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS, TRACE }

// typedefs

typedef AlsoWatch<T> = List<Relationship> Function(T);

typedef OnResponseSuccess<R> = R Function(dynamic);

typedef OnRequest<R> = Future<R> Function(http.Client);

// member extensions

extension ToStringX on DataRequestMethod {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension MapX<K, V> on Map<K, V> {
  String get id => this['id'] != null ? this['id'].toString() : null;
  Map<K, V> operator &(Map<K, V> more) => {...this, ...?more};
}

extension ListX<T> on List<T> {
  bool containsFirst(T model) => isNotEmpty ? first == model : false;
}

@optionalTypeArgs
extension IterableRelationshipExtension<T extends DataSupportMixin<T>>
    on Set<T> {
  HasMany<T> get asHasMany {
    if (isNotEmpty) {
      return HasMany<T>(this, first._manager);
    }
    return HasMany<T>();
  }
}

extension DataSupportMixinRelationshipExtension<T extends DataSupportMixin<T>>
    on DataSupportMixin<T> {
  BelongsTo<T> get asBelongsTo {
    return BelongsTo<T>(this as T, _manager);
  }
}

extension RelationshipIterableX on Map<String, Relationship> {
  Set<BelongsTo> get belongsTo => values.whereType<BelongsTo>().toSet();
  Set<HasMany> get hasMany => values.whereType<HasMany>().toSet();
}
