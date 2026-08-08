// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconCodeMeta = const VerificationMeta(
    'iconCode',
  );
  @override
  late final GeneratedColumn<String> iconCode = GeneratedColumn<String>(
    'icon_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('e532'),
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#C17F3A'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconCode,
    colorHex,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code')) {
      context.handle(
        _iconCodeMeta,
        iconCode.isAcceptableOrUnknown(data['icon_code']!, _iconCodeMeta),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_code'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String iconCode;
  final String colorHex;
  final int sortOrder;
  const Category({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.colorHex,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_code'] = Variable<String>(iconCode);
    map['color_hex'] = Variable<String>(colorHex);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconCode: Value(iconCode),
      colorHex: Value(colorHex),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconCode: serializer.fromJson<String>(json['iconCode']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconCode': serializer.toJson<String>(iconCode),
      'colorHex': serializer.toJson<String>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    String? iconCode,
    String? colorHex,
    int? sortOrder,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    iconCode: iconCode ?? this.iconCode,
    colorHex: colorHex ?? this.colorHex,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconCode: data.iconCode.present ? data.iconCode.value : this.iconCode,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconCode, colorHex, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconCode == this.iconCode &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> iconCode;
  final Value<String> colorHex;
  final Value<int> sortOrder;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconCode = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.iconCode = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconCode,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconCode != null) 'icon_code': iconCode,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? iconCode,
    Value<String>? colorHex,
    Value<int>? sortOrder,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconCode.present) {
      map['icon_code'] = Variable<String>(iconCode.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $MenuItemsTable extends MenuItems
    with TableInfo<$MenuItemsTable, MenuItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _basePriceMeta = const VerificationMeta(
    'basePrice',
  );
  @override
  late final GeneratedColumn<double> basePrice = GeneratedColumn<double>(
    'base_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _preparationStationMeta =
      const VerificationMeta('preparationStation');
  @override
  late final GeneratedColumn<String> preparationStation =
      GeneratedColumn<String>(
        'preparation_station',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('kitchen'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    description,
    basePrice,
    imageUrl,
    isAvailable,
    preparationStation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('base_price')) {
      context.handle(
        _basePriceMeta,
        basePrice.isAcceptableOrUnknown(data['base_price']!, _basePriceMeta),
      );
    } else if (isInserting) {
      context.missing(_basePriceMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('preparation_station')) {
      context.handle(
        _preparationStationMeta,
        preparationStation.isAcceptableOrUnknown(
          data['preparation_station']!,
          _preparationStationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      basePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_price'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      preparationStation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preparation_station'],
      )!,
    );
  }

  @override
  $MenuItemsTable createAlias(String alias) {
    return $MenuItemsTable(attachedDatabase, alias);
  }
}

class MenuItem extends DataClass implements Insertable<MenuItem> {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double basePrice;
  final String? imageUrl;
  final bool isAvailable;
  final String preparationStation;
  const MenuItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.basePrice,
    this.imageUrl,
    required this.isAvailable,
    required this.preparationStation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['base_price'] = Variable<double>(basePrice);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_available'] = Variable<bool>(isAvailable);
    map['preparation_station'] = Variable<String>(preparationStation);
    return map;
  }

  MenuItemsCompanion toCompanion(bool nullToAbsent) {
    return MenuItemsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: Value(description),
      basePrice: Value(basePrice),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isAvailable: Value(isAvailable),
      preparationStation: Value(preparationStation),
    );
  }

  factory MenuItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItem(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      basePrice: serializer.fromJson<double>(json['basePrice']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      preparationStation: serializer.fromJson<String>(
        json['preparationStation'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'basePrice': serializer.toJson<double>(basePrice),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'preparationStation': serializer.toJson<String>(preparationStation),
    };
  }

  MenuItem copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? description,
    double? basePrice,
    Value<String?> imageUrl = const Value.absent(),
    bool? isAvailable,
    String? preparationStation,
  }) => MenuItem(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description ?? this.description,
    basePrice: basePrice ?? this.basePrice,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    isAvailable: isAvailable ?? this.isAvailable,
    preparationStation: preparationStation ?? this.preparationStation,
  );
  MenuItem copyWithCompanion(MenuItemsCompanion data) {
    return MenuItem(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      basePrice: data.basePrice.present ? data.basePrice.value : this.basePrice,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      preparationStation: data.preparationStation.present
          ? data.preparationStation.value
          : this.preparationStation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItem(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basePrice: $basePrice, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('preparationStation: $preparationStation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    description,
    basePrice,
    imageUrl,
    isAvailable,
    preparationStation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItem &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.basePrice == this.basePrice &&
          other.imageUrl == this.imageUrl &&
          other.isAvailable == this.isAvailable &&
          other.preparationStation == this.preparationStation);
}

class MenuItemsCompanion extends UpdateCompanion<MenuItem> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String> description;
  final Value<double> basePrice;
  final Value<String?> imageUrl;
  final Value<bool> isAvailable;
  final Value<String> preparationStation;
  const MenuItemsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.basePrice = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.preparationStation = const Value.absent(),
  });
  MenuItemsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.description = const Value.absent(),
    required double basePrice,
    this.imageUrl = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.preparationStation = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name),
       basePrice = Value(basePrice);
  static Insertable<MenuItem> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? basePrice,
    Expression<String>? imageUrl,
    Expression<bool>? isAvailable,
    Expression<String>? preparationStation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (basePrice != null) 'base_price': basePrice,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isAvailable != null) 'is_available': isAvailable,
      if (preparationStation != null) 'preparation_station': preparationStation,
    });
  }

  MenuItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String>? description,
    Value<double>? basePrice,
    Value<String?>? imageUrl,
    Value<bool>? isAvailable,
    Value<String>? preparationStation,
  }) {
    return MenuItemsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      preparationStation: preparationStation ?? this.preparationStation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (basePrice.present) {
      map['base_price'] = Variable<double>(basePrice.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (preparationStation.present) {
      map['preparation_station'] = Variable<String>(preparationStation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('basePrice: $basePrice, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('preparationStation: $preparationStation')
          ..write(')'))
        .toString();
  }
}

class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<double> currentStock = GeneratedColumn<double>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reorderPointMeta = const VerificationMeta(
    'reorderPoint',
  );
  @override
  late final GeneratedColumn<double> reorderPoint = GeneratedColumn<double>(
    'reorder_point',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _costPerUnitMeta = const VerificationMeta(
    'costPerUnit',
  );
  @override
  late final GeneratedColumn<double> costPerUnit = GeneratedColumn<double>(
    'cost_per_unit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    unit,
    currentStock,
    reorderPoint,
    costPerUnit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    }
    if (data.containsKey('reorder_point')) {
      context.handle(
        _reorderPointMeta,
        reorderPoint.isAcceptableOrUnknown(
          data['reorder_point']!,
          _reorderPointMeta,
        ),
      );
    }
    if (data.containsKey('cost_per_unit')) {
      context.handle(
        _costPerUnitMeta,
        costPerUnit.isAcceptableOrUnknown(
          data['cost_per_unit']!,
          _costPerUnitMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_stock'],
      )!,
      reorderPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reorder_point'],
      )!,
      costPerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_per_unit'],
      )!,
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  final String unit;
  final double currentStock;
  final double reorderPoint;
  final double costPerUnit;
  const Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.currentStock,
    required this.reorderPoint,
    required this.costPerUnit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    map['current_stock'] = Variable<double>(currentStock);
    map['reorder_point'] = Variable<double>(reorderPoint);
    map['cost_per_unit'] = Variable<double>(costPerUnit);
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      name: Value(name),
      unit: Value(unit),
      currentStock: Value(currentStock),
      reorderPoint: Value(reorderPoint),
      costPerUnit: Value(costPerUnit),
    );
  }

  factory Ingredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
      currentStock: serializer.fromJson<double>(json['currentStock']),
      reorderPoint: serializer.fromJson<double>(json['reorderPoint']),
      costPerUnit: serializer.fromJson<double>(json['costPerUnit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
      'currentStock': serializer.toJson<double>(currentStock),
      'reorderPoint': serializer.toJson<double>(reorderPoint),
      'costPerUnit': serializer.toJson<double>(costPerUnit),
    };
  }

  Ingredient copyWith({
    int? id,
    String? name,
    String? unit,
    double? currentStock,
    double? reorderPoint,
    double? costPerUnit,
  }) => Ingredient(
    id: id ?? this.id,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    currentStock: currentStock ?? this.currentStock,
    reorderPoint: reorderPoint ?? this.reorderPoint,
    costPerUnit: costPerUnit ?? this.costPerUnit,
  );
  Ingredient copyWithCompanion(IngredientsCompanion data) {
    return Ingredient(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      reorderPoint: data.reorderPoint.present
          ? data.reorderPoint.value
          : this.reorderPoint,
      costPerUnit: data.costPerUnit.present
          ? data.costPerUnit.value
          : this.costPerUnit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('currentStock: $currentStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('costPerUnit: $costPerUnit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, unit, currentStock, reorderPoint, costPerUnit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.currentStock == this.currentStock &&
          other.reorderPoint == this.reorderPoint &&
          other.costPerUnit == this.costPerUnit);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> unit;
  final Value<double> currentStock;
  final Value<double> reorderPoint;
  final Value<double> costPerUnit;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.costPerUnit = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String unit,
    this.currentStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.costPerUnit = const Value.absent(),
  }) : name = Value(name),
       unit = Value(unit);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? currentStock,
    Expression<double>? reorderPoint,
    Expression<double>? costPerUnit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (currentStock != null) 'current_stock': currentStock,
      if (reorderPoint != null) 'reorder_point': reorderPoint,
      if (costPerUnit != null) 'cost_per_unit': costPerUnit,
    });
  }

  IngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? unit,
    Value<double>? currentStock,
    Value<double>? reorderPoint,
    Value<double>? costPerUnit,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      costPerUnit: costPerUnit ?? this.costPerUnit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<double>(currentStock.value);
    }
    if (reorderPoint.present) {
      map['reorder_point'] = Variable<double>(reorderPoint.value);
    }
    if (costPerUnit.present) {
      map['cost_per_unit'] = Variable<double>(costPerUnit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('currentStock: $currentStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('costPerUnit: $costPerUnit')
          ..write(')'))
        .toString();
  }
}

class $MenuItemIngredientsTable extends MenuItemIngredients
    with TableInfo<$MenuItemIngredientsTable, MenuItemIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _menuItemIdMeta = const VerificationMeta(
    'menuItemId',
  );
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
    'menu_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES menu_items (id)',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _quantityRequiredMeta = const VerificationMeta(
    'quantityRequired',
  );
  @override
  late final GeneratedColumn<double> quantityRequired = GeneratedColumn<double>(
    'quantity_required',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    menuItemId,
    ingredientId,
    quantityRequired,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_item_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuItemIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('menu_item_id')) {
      context.handle(
        _menuItemIdMeta,
        menuItemId.isAcceptableOrUnknown(
          data['menu_item_id']!,
          _menuItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('quantity_required')) {
      context.handle(
        _quantityRequiredMeta,
        quantityRequired.isAcceptableOrUnknown(
          data['quantity_required']!,
          _quantityRequiredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityRequiredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {menuItemId, ingredientId};
  @override
  MenuItemIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItemIngredient(
      menuItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_item_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      quantityRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_required'],
      )!,
    );
  }

  @override
  $MenuItemIngredientsTable createAlias(String alias) {
    return $MenuItemIngredientsTable(attachedDatabase, alias);
  }
}

class MenuItemIngredient extends DataClass
    implements Insertable<MenuItemIngredient> {
  final int menuItemId;
  final int ingredientId;
  final double quantityRequired;
  const MenuItemIngredient({
    required this.menuItemId,
    required this.ingredientId,
    required this.quantityRequired,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['menu_item_id'] = Variable<int>(menuItemId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['quantity_required'] = Variable<double>(quantityRequired);
    return map;
  }

  MenuItemIngredientsCompanion toCompanion(bool nullToAbsent) {
    return MenuItemIngredientsCompanion(
      menuItemId: Value(menuItemId),
      ingredientId: Value(ingredientId),
      quantityRequired: Value(quantityRequired),
    );
  }

  factory MenuItemIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItemIngredient(
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      quantityRequired: serializer.fromJson<double>(json['quantityRequired']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'menuItemId': serializer.toJson<int>(menuItemId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'quantityRequired': serializer.toJson<double>(quantityRequired),
    };
  }

  MenuItemIngredient copyWith({
    int? menuItemId,
    int? ingredientId,
    double? quantityRequired,
  }) => MenuItemIngredient(
    menuItemId: menuItemId ?? this.menuItemId,
    ingredientId: ingredientId ?? this.ingredientId,
    quantityRequired: quantityRequired ?? this.quantityRequired,
  );
  MenuItemIngredient copyWithCompanion(MenuItemIngredientsCompanion data) {
    return MenuItemIngredient(
      menuItemId: data.menuItemId.present
          ? data.menuItemId.value
          : this.menuItemId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      quantityRequired: data.quantityRequired.present
          ? data.quantityRequired.value
          : this.quantityRequired,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemIngredient(')
          ..write('menuItemId: $menuItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantityRequired: $quantityRequired')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(menuItemId, ingredientId, quantityRequired);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItemIngredient &&
          other.menuItemId == this.menuItemId &&
          other.ingredientId == this.ingredientId &&
          other.quantityRequired == this.quantityRequired);
}

class MenuItemIngredientsCompanion extends UpdateCompanion<MenuItemIngredient> {
  final Value<int> menuItemId;
  final Value<int> ingredientId;
  final Value<double> quantityRequired;
  final Value<int> rowid;
  const MenuItemIngredientsCompanion({
    this.menuItemId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.quantityRequired = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MenuItemIngredientsCompanion.insert({
    required int menuItemId,
    required int ingredientId,
    required double quantityRequired,
    this.rowid = const Value.absent(),
  }) : menuItemId = Value(menuItemId),
       ingredientId = Value(ingredientId),
       quantityRequired = Value(quantityRequired);
  static Insertable<MenuItemIngredient> custom({
    Expression<int>? menuItemId,
    Expression<int>? ingredientId,
    Expression<double>? quantityRequired,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (quantityRequired != null) 'quantity_required': quantityRequired,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MenuItemIngredientsCompanion copyWith({
    Value<int>? menuItemId,
    Value<int>? ingredientId,
    Value<double>? quantityRequired,
    Value<int>? rowid,
  }) {
    return MenuItemIngredientsCompanion(
      menuItemId: menuItemId ?? this.menuItemId,
      ingredientId: ingredientId ?? this.ingredientId,
      quantityRequired: quantityRequired ?? this.quantityRequired,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (quantityRequired.present) {
      map['quantity_required'] = Variable<double>(quantityRequired.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemIngredientsCompanion(')
          ..write('menuItemId: $menuItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantityRequired: $quantityRequired, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderTypeMeta = const VerificationMeta(
    'orderType',
  );
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
    'order_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('takeaway'),
  );
  static const VerificationMeta _tableNumberMeta = const VerificationMeta(
    'tableNumber',
  );
  @override
  late final GeneratedColumn<int> tableNumber = GeneratedColumn<int>(
    'table_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tenderedAmountMeta = const VerificationMeta(
    'tenderedAmount',
  );
  @override
  late final GeneratedColumn<double> tenderedAmount = GeneratedColumn<double>(
    'tendered_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderNumber,
    orderType,
    tableNumber,
    status,
    createdAt,
    completedAt,
    subtotal,
    taxAmount,
    totalAmount,
    paymentMethod,
    tenderedAmount,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('order_type')) {
      context.handle(
        _orderTypeMeta,
        orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta),
      );
    }
    if (data.containsKey('table_number')) {
      context.handle(
        _tableNumberMeta,
        tableNumber.isAcceptableOrUnknown(
          data['table_number']!,
          _tableNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('tendered_amount')) {
      context.handle(
        _tenderedAmountMeta,
        tenderedAmount.isAcceptableOrUnknown(
          data['tendered_amount']!,
          _tenderedAmountMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      orderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_type'],
      )!,
      tableNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}table_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      tenderedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tendered_amount'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String orderNumber;
  final String orderType;
  final int? tableNumber;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double subtotal;
  final double taxAmount;
  final double totalAmount;
  final String? paymentMethod;
  final double? tenderedAmount;
  final String notes;
  const Order({
    required this.id,
    required this.orderNumber,
    required this.orderType,
    this.tableNumber,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
    this.paymentMethod,
    this.tenderedAmount,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_number'] = Variable<String>(orderNumber);
    map['order_type'] = Variable<String>(orderType);
    if (!nullToAbsent || tableNumber != null) {
      map['table_number'] = Variable<int>(tableNumber);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || tenderedAmount != null) {
      map['tendered_amount'] = Variable<double>(tenderedAmount);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      orderNumber: Value(orderNumber),
      orderType: Value(orderType),
      tableNumber: tableNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(tableNumber),
      status: Value(status),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      subtotal: Value(subtotal),
      taxAmount: Value(taxAmount),
      totalAmount: Value(totalAmount),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      tenderedAmount: tenderedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(tenderedAmount),
      notes: Value(notes),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      orderType: serializer.fromJson<String>(json['orderType']),
      tableNumber: serializer.fromJson<int?>(json['tableNumber']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      tenderedAmount: serializer.fromJson<double?>(json['tenderedAmount']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'orderType': serializer.toJson<String>(orderType),
      'tableNumber': serializer.toJson<int?>(tableNumber),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'subtotal': serializer.toJson<double>(subtotal),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'tenderedAmount': serializer.toJson<double?>(tenderedAmount),
      'notes': serializer.toJson<String>(notes),
    };
  }

  Order copyWith({
    int? id,
    String? orderNumber,
    String? orderType,
    Value<int?> tableNumber = const Value.absent(),
    String? status,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
    double? subtotal,
    double? taxAmount,
    double? totalAmount,
    Value<String?> paymentMethod = const Value.absent(),
    Value<double?> tenderedAmount = const Value.absent(),
    String? notes,
  }) => Order(
    id: id ?? this.id,
    orderNumber: orderNumber ?? this.orderNumber,
    orderType: orderType ?? this.orderType,
    tableNumber: tableNumber.present ? tableNumber.value : this.tableNumber,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    subtotal: subtotal ?? this.subtotal,
    taxAmount: taxAmount ?? this.taxAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    tenderedAmount: tenderedAmount.present
        ? tenderedAmount.value
        : this.tenderedAmount,
    notes: notes ?? this.notes,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      tableNumber: data.tableNumber.present
          ? data.tableNumber.value
          : this.tableNumber,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      tenderedAmount: data.tenderedAmount.present
          ? data.tenderedAmount.value
          : this.tenderedAmount,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('tableNumber: $tableNumber, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('tenderedAmount: $tenderedAmount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderNumber,
    orderType,
    tableNumber,
    status,
    createdAt,
    completedAt,
    subtotal,
    taxAmount,
    totalAmount,
    paymentMethod,
    tenderedAmount,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.orderNumber == this.orderNumber &&
          other.orderType == this.orderType &&
          other.tableNumber == this.tableNumber &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.subtotal == this.subtotal &&
          other.taxAmount == this.taxAmount &&
          other.totalAmount == this.totalAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.tenderedAmount == this.tenderedAmount &&
          other.notes == this.notes);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String> orderNumber;
  final Value<String> orderType;
  final Value<int?> tableNumber;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<double> subtotal;
  final Value<double> taxAmount;
  final Value<double> totalAmount;
  final Value<String?> paymentMethod;
  final Value<double?> tenderedAmount;
  final Value<String> notes;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.orderType = const Value.absent(),
    this.tableNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.tenderedAmount = const Value.absent(),
    this.notes = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNumber,
    this.orderType = const Value.absent(),
    this.tableNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.tenderedAmount = const Value.absent(),
    this.notes = const Value.absent(),
  }) : orderNumber = Value(orderNumber);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? orderNumber,
    Expression<String>? orderType,
    Expression<int>? tableNumber,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<double>? subtotal,
    Expression<double>? taxAmount,
    Expression<double>? totalAmount,
    Expression<String>? paymentMethod,
    Expression<double>? tenderedAmount,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNumber != null) 'order_number': orderNumber,
      if (orderType != null) 'order_type': orderType,
      if (tableNumber != null) 'table_number': tableNumber,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (subtotal != null) 'subtotal': subtotal,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (tenderedAmount != null) 'tendered_amount': tenderedAmount,
      if (notes != null) 'notes': notes,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? orderNumber,
    Value<String>? orderType,
    Value<int?>? tableNumber,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<double>? subtotal,
    Value<double>? taxAmount,
    Value<double>? totalAmount,
    Value<String?>? paymentMethod,
    Value<double?>? tenderedAmount,
    Value<String>? notes,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      orderType: orderType ?? this.orderType,
      tableNumber: tableNumber ?? this.tableNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tenderedAmount: tenderedAmount ?? this.tenderedAmount,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (tableNumber.present) {
      map['table_number'] = Variable<int>(tableNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (tenderedAmount.present) {
      map['tendered_amount'] = Variable<double>(tenderedAmount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('tableNumber: $tableNumber, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('tenderedAmount: $tenderedAmount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems
    with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _menuItemIdMeta = const VerificationMeta(
    'menuItemId',
  );
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
    'menu_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES menu_items (id)',
    ),
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiersMeta = const VerificationMeta(
    'modifiers',
  );
  @override
  late final GeneratedColumn<String> modifiers = GeneratedColumn<String>(
    'modifiers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    menuItemId,
    itemName,
    quantity,
    unitPrice,
    subtotal,
    modifiers,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('menu_item_id')) {
      context.handle(
        _menuItemIdMeta,
        menuItemId.isAcceptableOrUnknown(
          data['menu_item_id']!,
          _menuItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('modifiers')) {
      context.handle(
        _modifiersMeta,
        modifiers.isAcceptableOrUnknown(data['modifiers']!, _modifiersMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      menuItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_item_id'],
      )!,
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      modifiers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modifiers'],
      )!,
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final int id;
  final int orderId;
  final int menuItemId;
  final String itemName;
  final int quantity;
  final double unitPrice;
  final double subtotal;
  final String modifiers;
  const OrderItem({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.modifiers,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['menu_item_id'] = Variable<int>(menuItemId);
    map['item_name'] = Variable<String>(itemName);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['subtotal'] = Variable<double>(subtotal);
    map['modifiers'] = Variable<String>(modifiers);
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      menuItemId: Value(menuItemId),
      itemName: Value(itemName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      subtotal: Value(subtotal),
      modifiers: Value(modifiers),
    );
  }

  factory OrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      modifiers: serializer.fromJson<String>(json['modifiers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'menuItemId': serializer.toJson<int>(menuItemId),
      'itemName': serializer.toJson<String>(itemName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subtotal': serializer.toJson<double>(subtotal),
      'modifiers': serializer.toJson<String>(modifiers),
    };
  }

  OrderItem copyWith({
    int? id,
    int? orderId,
    int? menuItemId,
    String? itemName,
    int? quantity,
    double? unitPrice,
    double? subtotal,
    String? modifiers,
  }) => OrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    menuItemId: menuItemId ?? this.menuItemId,
    itemName: itemName ?? this.itemName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    subtotal: subtotal ?? this.subtotal,
    modifiers: modifiers ?? this.modifiers,
  );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      menuItemId: data.menuItemId.present
          ? data.menuItemId.value
          : this.menuItemId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      modifiers: data.modifiers.present ? data.modifiers.value : this.modifiers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('modifiers: $modifiers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    menuItemId,
    itemName,
    quantity,
    unitPrice,
    subtotal,
    modifiers,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.menuItemId == this.menuItemId &&
          other.itemName == this.itemName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.subtotal == this.subtotal &&
          other.modifiers == this.modifiers);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> menuItemId;
  final Value<String> itemName;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> subtotal;
  final Value<String> modifiers;
  const OrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.menuItemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.modifiers = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int menuItemId,
    required String itemName,
    required int quantity,
    required double unitPrice,
    required double subtotal,
    this.modifiers = const Value.absent(),
  }) : orderId = Value(orderId),
       menuItemId = Value(menuItemId),
       itemName = Value(itemName),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       subtotal = Value(subtotal);
  static Insertable<OrderItem> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? menuItemId,
    Expression<String>? itemName,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? subtotal,
    Expression<String>? modifiers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (itemName != null) 'item_name': itemName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (subtotal != null) 'subtotal': subtotal,
      if (modifiers != null) 'modifiers': modifiers,
    });
  }

  OrderItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<int>? menuItemId,
    Value<String>? itemName,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? subtotal,
    Value<String>? modifiers,
  }) {
    return OrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId ?? this.menuItemId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      subtotal: subtotal ?? this.subtotal,
      modifiers: modifiers ?? this.modifiers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (modifiers.present) {
      map['modifiers'] = Variable<String>(modifiers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('itemName: $itemName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('modifiers: $modifiers')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('opening'),
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<String> assignedTo = GeneratedColumn<String>(
    'assigned_to',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('todo'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedByMeta = const VerificationMeta(
    'completedBy',
  );
  @override
  late final GeneratedColumn<String> completedBy = GeneratedColumn<String>(
    'completed_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    category,
    assignedTo,
    status,
    priority,
    dueDate,
    completedAt,
    completedBy,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('completed_by')) {
      context.handle(
        _completedByMeta,
        completedBy.isAcceptableOrUnknown(
          data['completed_by']!,
          _completedByMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_to'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      completedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String description;
  final String category;
  final String? assignedTo;
  final String status;
  final String priority;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final String? completedBy;
  final DateTime createdAt;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.assignedTo,
    required this.status,
    required this.priority,
    this.dueDate,
    this.completedAt,
    this.completedBy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || assignedTo != null) {
      map['assigned_to'] = Variable<String>(assignedTo);
    }
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || completedBy != null) {
      map['completed_by'] = Variable<String>(completedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      assignedTo: assignedTo == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedTo),
      status: Value(status),
      priority: Value(priority),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      completedBy: completedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(completedBy),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      assignedTo: serializer.fromJson<String?>(json['assignedTo']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      completedBy: serializer.fromJson<String?>(json['completedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'assignedTo': serializer.toJson<String?>(assignedTo),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'completedBy': serializer.toJson<String?>(completedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    Value<String?> assignedTo = const Value.absent(),
    String? status,
    String? priority,
    Value<DateTime?> dueDate = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> completedBy = const Value.absent(),
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    assignedTo: assignedTo.present ? assignedTo.value : this.assignedTo,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    completedBy: completedBy.present ? completedBy.value : this.completedBy,
    createdAt: createdAt ?? this.createdAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      completedBy: data.completedBy.present
          ? data.completedBy.value
          : this.completedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('completedBy: $completedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    category,
    assignedTo,
    status,
    priority,
    dueDate,
    completedAt,
    completedBy,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.assignedTo == this.assignedTo &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.dueDate == this.dueDate &&
          other.completedAt == this.completedAt &&
          other.completedBy == this.completedBy &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<String?> assignedTo;
  final Value<String> status;
  final Value<String> priority;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> completedAt;
  final Value<String?> completedBy;
  final Value<DateTime> createdAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? assignedTo,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? completedAt,
    Expression<String>? completedBy,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (dueDate != null) 'due_date': dueDate,
      if (completedAt != null) 'completed_at': completedAt,
      if (completedBy != null) 'completed_by': completedBy,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<String?>? assignedTo,
    Value<String>? status,
    Value<String>? priority,
    Value<DateTime?>? dueDate,
    Value<DateTime?>? completedAt,
    Value<String?>? completedBy,
    Value<DateTime>? createdAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      completedBy: completedBy ?? this.completedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<String>(assignedTo.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (completedBy.present) {
      map['completed_by'] = Variable<String>(completedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('completedBy: $completedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Bronze'),
  );
  static const VerificationMeta _totalSpentMeta = const VerificationMeta(
    'totalSpent',
  );
  @override
  late final GeneratedColumn<double> totalSpent = GeneratedColumn<double>(
    'total_spent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _stampsCountMeta = const VerificationMeta(
    'stampsCount',
  );
  @override
  late final GeneratedColumn<int> stampsCount = GeneratedColumn<int>(
    'stamps_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastVisitedAtMeta = const VerificationMeta(
    'lastVisitedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastVisitedAt =
      GeneratedColumn<DateTime>(
        'last_visited_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    points,
    tier,
    totalSpent,
    stampsCount,
    createdAt,
    lastVisitedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('total_spent')) {
      context.handle(
        _totalSpentMeta,
        totalSpent.isAcceptableOrUnknown(data['total_spent']!, _totalSpentMeta),
      );
    }
    if (data.containsKey('stamps_count')) {
      context.handle(
        _stampsCountMeta,
        stampsCount.isAcceptableOrUnknown(
          data['stamps_count']!,
          _stampsCountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_visited_at')) {
      context.handle(
        _lastVisitedAtMeta,
        lastVisitedAt.isAcceptableOrUnknown(
          data['last_visited_at']!,
          _lastVisitedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      totalSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_spent'],
      )!,
      stampsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stamps_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastVisitedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_visited_at'],
      ),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final int points;
  final String tier;
  final double totalSpent;
  final int stampsCount;
  final DateTime createdAt;
  final DateTime? lastVisitedAt;
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.points,
    required this.tier,
    required this.totalSpent,
    required this.stampsCount,
    required this.createdAt,
    this.lastVisitedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['points'] = Variable<int>(points);
    map['tier'] = Variable<String>(tier);
    map['total_spent'] = Variable<double>(totalSpent);
    map['stamps_count'] = Variable<int>(stampsCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastVisitedAt != null) {
      map['last_visited_at'] = Variable<DateTime>(lastVisitedAt);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      points: Value(points),
      tier: Value(tier),
      totalSpent: Value(totalSpent),
      stampsCount: Value(stampsCount),
      createdAt: Value(createdAt),
      lastVisitedAt: lastVisitedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVisitedAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      points: serializer.fromJson<int>(json['points']),
      tier: serializer.fromJson<String>(json['tier']),
      totalSpent: serializer.fromJson<double>(json['totalSpent']),
      stampsCount: serializer.fromJson<int>(json['stampsCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastVisitedAt: serializer.fromJson<DateTime?>(json['lastVisitedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
      'points': serializer.toJson<int>(points),
      'tier': serializer.toJson<String>(tier),
      'totalSpent': serializer.toJson<double>(totalSpent),
      'stampsCount': serializer.toJson<int>(stampsCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastVisitedAt': serializer.toJson<DateTime?>(lastVisitedAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    Value<String?> email = const Value.absent(),
    int? points,
    String? tier,
    double? totalSpent,
    int? stampsCount,
    DateTime? createdAt,
    Value<DateTime?> lastVisitedAt = const Value.absent(),
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email.present ? email.value : this.email,
    points: points ?? this.points,
    tier: tier ?? this.tier,
    totalSpent: totalSpent ?? this.totalSpent,
    stampsCount: stampsCount ?? this.stampsCount,
    createdAt: createdAt ?? this.createdAt,
    lastVisitedAt: lastVisitedAt.present
        ? lastVisitedAt.value
        : this.lastVisitedAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      points: data.points.present ? data.points.value : this.points,
      tier: data.tier.present ? data.tier.value : this.tier,
      totalSpent: data.totalSpent.present
          ? data.totalSpent.value
          : this.totalSpent,
      stampsCount: data.stampsCount.present
          ? data.stampsCount.value
          : this.stampsCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastVisitedAt: data.lastVisitedAt.present
          ? data.lastVisitedAt.value
          : this.lastVisitedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('points: $points, ')
          ..write('tier: $tier, ')
          ..write('totalSpent: $totalSpent, ')
          ..write('stampsCount: $stampsCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastVisitedAt: $lastVisitedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    email,
    points,
    tier,
    totalSpent,
    stampsCount,
    createdAt,
    lastVisitedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.points == this.points &&
          other.tier == this.tier &&
          other.totalSpent == this.totalSpent &&
          other.stampsCount == this.stampsCount &&
          other.createdAt == this.createdAt &&
          other.lastVisitedAt == this.lastVisitedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> email;
  final Value<int> points;
  final Value<String> tier;
  final Value<double> totalSpent;
  final Value<int> stampsCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastVisitedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.points = const Value.absent(),
    this.tier = const Value.absent(),
    this.totalSpent = const Value.absent(),
    this.stampsCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastVisitedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.email = const Value.absent(),
    this.points = const Value.absent(),
    this.tier = const Value.absent(),
    this.totalSpent = const Value.absent(),
    this.stampsCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastVisitedAt = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<int>? points,
    Expression<String>? tier,
    Expression<double>? totalSpent,
    Expression<int>? stampsCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastVisitedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (points != null) 'points': points,
      if (tier != null) 'tier': tier,
      if (totalSpent != null) 'total_spent': totalSpent,
      if (stampsCount != null) 'stamps_count': stampsCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastVisitedAt != null) 'last_visited_at': lastVisitedAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? email,
    Value<int>? points,
    Value<String>? tier,
    Value<double>? totalSpent,
    Value<int>? stampsCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastVisitedAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      points: points ?? this.points,
      tier: tier ?? this.tier,
      totalSpent: totalSpent ?? this.totalSpent,
      stampsCount: stampsCount ?? this.stampsCount,
      createdAt: createdAt ?? this.createdAt,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (totalSpent.present) {
      map['total_spent'] = Variable<double>(totalSpent.value);
    }
    if (stampsCount.present) {
      map['stamps_count'] = Variable<int>(stampsCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastVisitedAt.present) {
      map['last_visited_at'] = Variable<DateTime>(lastVisitedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('points: $points, ')
          ..write('tier: $tier, ')
          ..write('totalSpent: $totalSpent, ')
          ..write('stampsCount: $stampsCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastVisitedAt: $lastVisitedAt')
          ..write(')'))
        .toString();
  }
}

class $StaffMembersTable extends StaffMembers
    with TableInfo<$StaffMembersTable, StaffMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Cashier'),
  );
  static const VerificationMeta _pinCodeMeta = const VerificationMeta(
    'pinCode',
  );
  @override
  late final GeneratedColumn<String> pinCode = GeneratedColumn<String>(
    'pin_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1234'),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    role,
    pinCode,
    phone,
    isActive,
    hourlyRate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('pin_code')) {
      context.handle(
        _pinCodeMeta,
        pinCode.isAcceptableOrUnknown(data['pin_code']!, _pinCodeMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pinCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_code'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StaffMembersTable createAlias(String alias) {
    return $StaffMembersTable(attachedDatabase, alias);
  }
}

class StaffMember extends DataClass implements Insertable<StaffMember> {
  final int id;
  final String name;
  final String role;
  final String pinCode;
  final String? phone;
  final bool isActive;
  final double hourlyRate;
  final DateTime createdAt;
  const StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.pinCode,
    this.phone,
    required this.isActive,
    required this.hourlyRate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    map['pin_code'] = Variable<String>(pinCode);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['hourly_rate'] = Variable<double>(hourlyRate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StaffMembersCompanion toCompanion(bool nullToAbsent) {
    return StaffMembersCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      pinCode: Value(pinCode),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      isActive: Value(isActive),
      hourlyRate: Value(hourlyRate),
      createdAt: Value(createdAt),
    );
  }

  factory StaffMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffMember(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      phone: serializer.fromJson<String?>(json['phone']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      hourlyRate: serializer.fromJson<double>(json['hourlyRate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'pinCode': serializer.toJson<String>(pinCode),
      'phone': serializer.toJson<String?>(phone),
      'isActive': serializer.toJson<bool>(isActive),
      'hourlyRate': serializer.toJson<double>(hourlyRate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StaffMember copyWith({
    int? id,
    String? name,
    String? role,
    String? pinCode,
    Value<String?> phone = const Value.absent(),
    bool? isActive,
    double? hourlyRate,
    DateTime? createdAt,
  }) => StaffMember(
    id: id ?? this.id,
    name: name ?? this.name,
    role: role ?? this.role,
    pinCode: pinCode ?? this.pinCode,
    phone: phone.present ? phone.value : this.phone,
    isActive: isActive ?? this.isActive,
    hourlyRate: hourlyRate ?? this.hourlyRate,
    createdAt: createdAt ?? this.createdAt,
  );
  StaffMember copyWithCompanion(StaffMembersCompanion data) {
    return StaffMember(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      pinCode: data.pinCode.present ? data.pinCode.value : this.pinCode,
      phone: data.phone.present ? data.phone.value : this.phone,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffMember(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinCode: $pinCode, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    role,
    pinCode,
    phone,
    isActive,
    hourlyRate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffMember &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.pinCode == this.pinCode &&
          other.phone == this.phone &&
          other.isActive == this.isActive &&
          other.hourlyRate == this.hourlyRate &&
          other.createdAt == this.createdAt);
}

class StaffMembersCompanion extends UpdateCompanion<StaffMember> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String> pinCode;
  final Value<String?> phone;
  final Value<bool> isActive;
  final Value<double> hourlyRate;
  final Value<DateTime> createdAt;
  const StaffMembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StaffMembersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.role = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<StaffMember> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? pinCode,
    Expression<String>? phone,
    Expression<bool>? isActive,
    Expression<double>? hourlyRate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (pinCode != null) 'pin_code': pinCode,
      if (phone != null) 'phone': phone,
      if (isActive != null) 'is_active': isActive,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StaffMembersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? role,
    Value<String>? pinCode,
    Value<String?>? phone,
    Value<bool>? isActive,
    Value<double>? hourlyRate,
    Value<DateTime>? createdAt,
  }) {
    return StaffMembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      pinCode: pinCode ?? this.pinCode,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pinCode.present) {
      map['pin_code'] = Variable<String>(pinCode.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffMembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinCode: $pinCode, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StaffAttendancesTable extends StaffAttendances
    with TableInfo<$StaffAttendancesTable, StaffAttendance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffAttendancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES staff_members (id)',
    ),
  );
  static const VerificationMeta _staffNameMeta = const VerificationMeta(
    'staffName',
  );
  @override
  late final GeneratedColumn<String> staffName = GeneratedColumn<String>(
    'staff_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clockInTimeMeta = const VerificationMeta(
    'clockInTime',
  );
  @override
  late final GeneratedColumn<DateTime> clockInTime = GeneratedColumn<DateTime>(
    'clock_in_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _clockOutTimeMeta = const VerificationMeta(
    'clockOutTime',
  );
  @override
  late final GeneratedColumn<DateTime> clockOutTime = GeneratedColumn<DateTime>(
    'clock_out_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMinutesMeta = const VerificationMeta(
    'totalMinutes',
  );
  @override
  late final GeneratedColumn<int> totalMinutes = GeneratedColumn<int>(
    'total_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    staffId,
    staffName,
    clockInTime,
    clockOutTime,
    totalMinutes,
    notes,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff_attendances';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffAttendance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('staff_name')) {
      context.handle(
        _staffNameMeta,
        staffName.isAcceptableOrUnknown(data['staff_name']!, _staffNameMeta),
      );
    } else if (isInserting) {
      context.missing(_staffNameMeta);
    }
    if (data.containsKey('clock_in_time')) {
      context.handle(
        _clockInTimeMeta,
        clockInTime.isAcceptableOrUnknown(
          data['clock_in_time']!,
          _clockInTimeMeta,
        ),
      );
    }
    if (data.containsKey('clock_out_time')) {
      context.handle(
        _clockOutTimeMeta,
        clockOutTime.isAcceptableOrUnknown(
          data['clock_out_time']!,
          _clockOutTimeMeta,
        ),
      );
    }
    if (data.containsKey('total_minutes')) {
      context.handle(
        _totalMinutesMeta,
        totalMinutes.isAcceptableOrUnknown(
          data['total_minutes']!,
          _totalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffAttendance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffAttendance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}staff_id'],
      )!,
      staffName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_name'],
      )!,
      clockInTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}clock_in_time'],
      )!,
      clockOutTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}clock_out_time'],
      ),
      totalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_minutes'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $StaffAttendancesTable createAlias(String alias) {
    return $StaffAttendancesTable(attachedDatabase, alias);
  }
}

class StaffAttendance extends DataClass implements Insertable<StaffAttendance> {
  final int id;
  final int staffId;
  final String staffName;
  final DateTime clockInTime;
  final DateTime? clockOutTime;
  final int totalMinutes;
  final String notes;
  final String date;
  const StaffAttendance({
    required this.id,
    required this.staffId,
    required this.staffName,
    required this.clockInTime,
    this.clockOutTime,
    required this.totalMinutes,
    required this.notes,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['staff_id'] = Variable<int>(staffId);
    map['staff_name'] = Variable<String>(staffName);
    map['clock_in_time'] = Variable<DateTime>(clockInTime);
    if (!nullToAbsent || clockOutTime != null) {
      map['clock_out_time'] = Variable<DateTime>(clockOutTime);
    }
    map['total_minutes'] = Variable<int>(totalMinutes);
    map['notes'] = Variable<String>(notes);
    map['date'] = Variable<String>(date);
    return map;
  }

  StaffAttendancesCompanion toCompanion(bool nullToAbsent) {
    return StaffAttendancesCompanion(
      id: Value(id),
      staffId: Value(staffId),
      staffName: Value(staffName),
      clockInTime: Value(clockInTime),
      clockOutTime: clockOutTime == null && nullToAbsent
          ? const Value.absent()
          : Value(clockOutTime),
      totalMinutes: Value(totalMinutes),
      notes: Value(notes),
      date: Value(date),
    );
  }

  factory StaffAttendance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffAttendance(
      id: serializer.fromJson<int>(json['id']),
      staffId: serializer.fromJson<int>(json['staffId']),
      staffName: serializer.fromJson<String>(json['staffName']),
      clockInTime: serializer.fromJson<DateTime>(json['clockInTime']),
      clockOutTime: serializer.fromJson<DateTime?>(json['clockOutTime']),
      totalMinutes: serializer.fromJson<int>(json['totalMinutes']),
      notes: serializer.fromJson<String>(json['notes']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'staffId': serializer.toJson<int>(staffId),
      'staffName': serializer.toJson<String>(staffName),
      'clockInTime': serializer.toJson<DateTime>(clockInTime),
      'clockOutTime': serializer.toJson<DateTime?>(clockOutTime),
      'totalMinutes': serializer.toJson<int>(totalMinutes),
      'notes': serializer.toJson<String>(notes),
      'date': serializer.toJson<String>(date),
    };
  }

  StaffAttendance copyWith({
    int? id,
    int? staffId,
    String? staffName,
    DateTime? clockInTime,
    Value<DateTime?> clockOutTime = const Value.absent(),
    int? totalMinutes,
    String? notes,
    String? date,
  }) => StaffAttendance(
    id: id ?? this.id,
    staffId: staffId ?? this.staffId,
    staffName: staffName ?? this.staffName,
    clockInTime: clockInTime ?? this.clockInTime,
    clockOutTime: clockOutTime.present ? clockOutTime.value : this.clockOutTime,
    totalMinutes: totalMinutes ?? this.totalMinutes,
    notes: notes ?? this.notes,
    date: date ?? this.date,
  );
  StaffAttendance copyWithCompanion(StaffAttendancesCompanion data) {
    return StaffAttendance(
      id: data.id.present ? data.id.value : this.id,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      staffName: data.staffName.present ? data.staffName.value : this.staffName,
      clockInTime: data.clockInTime.present
          ? data.clockInTime.value
          : this.clockInTime,
      clockOutTime: data.clockOutTime.present
          ? data.clockOutTime.value
          : this.clockOutTime,
      totalMinutes: data.totalMinutes.present
          ? data.totalMinutes.value
          : this.totalMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffAttendance(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('clockInTime: $clockInTime, ')
          ..write('clockOutTime: $clockOutTime, ')
          ..write('totalMinutes: $totalMinutes, ')
          ..write('notes: $notes, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    staffId,
    staffName,
    clockInTime,
    clockOutTime,
    totalMinutes,
    notes,
    date,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffAttendance &&
          other.id == this.id &&
          other.staffId == this.staffId &&
          other.staffName == this.staffName &&
          other.clockInTime == this.clockInTime &&
          other.clockOutTime == this.clockOutTime &&
          other.totalMinutes == this.totalMinutes &&
          other.notes == this.notes &&
          other.date == this.date);
}

class StaffAttendancesCompanion extends UpdateCompanion<StaffAttendance> {
  final Value<int> id;
  final Value<int> staffId;
  final Value<String> staffName;
  final Value<DateTime> clockInTime;
  final Value<DateTime?> clockOutTime;
  final Value<int> totalMinutes;
  final Value<String> notes;
  final Value<String> date;
  const StaffAttendancesCompanion({
    this.id = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.clockInTime = const Value.absent(),
    this.clockOutTime = const Value.absent(),
    this.totalMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
  });
  StaffAttendancesCompanion.insert({
    this.id = const Value.absent(),
    required int staffId,
    required String staffName,
    this.clockInTime = const Value.absent(),
    this.clockOutTime = const Value.absent(),
    this.totalMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    required String date,
  }) : staffId = Value(staffId),
       staffName = Value(staffName),
       date = Value(date);
  static Insertable<StaffAttendance> custom({
    Expression<int>? id,
    Expression<int>? staffId,
    Expression<String>? staffName,
    Expression<DateTime>? clockInTime,
    Expression<DateTime>? clockOutTime,
    Expression<int>? totalMinutes,
    Expression<String>? notes,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (staffId != null) 'staff_id': staffId,
      if (staffName != null) 'staff_name': staffName,
      if (clockInTime != null) 'clock_in_time': clockInTime,
      if (clockOutTime != null) 'clock_out_time': clockOutTime,
      if (totalMinutes != null) 'total_minutes': totalMinutes,
      if (notes != null) 'notes': notes,
      if (date != null) 'date': date,
    });
  }

  StaffAttendancesCompanion copyWith({
    Value<int>? id,
    Value<int>? staffId,
    Value<String>? staffName,
    Value<DateTime>? clockInTime,
    Value<DateTime?>? clockOutTime,
    Value<int>? totalMinutes,
    Value<String>? notes,
    Value<String>? date,
  }) {
    return StaffAttendancesCompanion(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      clockInTime: clockInTime ?? this.clockInTime,
      clockOutTime: clockOutTime ?? this.clockOutTime,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      notes: notes ?? this.notes,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (staffName.present) {
      map['staff_name'] = Variable<String>(staffName.value);
    }
    if (clockInTime.present) {
      map['clock_in_time'] = Variable<DateTime>(clockInTime.value);
    }
    if (clockOutTime.present) {
      map['clock_out_time'] = Variable<DateTime>(clockOutTime.value);
    }
    if (totalMinutes.present) {
      map['total_minutes'] = Variable<int>(totalMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffAttendancesCompanion(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('clockInTime: $clockInTime, ')
          ..write('clockOutTime: $clockOutTime, ')
          ..write('totalMinutes: $totalMinutes, ')
          ..write('notes: $notes, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactPersonMeta = const VerificationMeta(
    'contactPerson',
  );
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
    'contact_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentTermsMeta = const VerificationMeta(
    'paymentTerms',
  );
  @override
  late final GeneratedColumn<String> paymentTerms = GeneratedColumn<String>(
    'payment_terms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('COD'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Coffee Beans'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contactPerson,
    phone,
    email,
    address,
    paymentTerms,
    category,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_person')) {
      context.handle(
        _contactPersonMeta,
        contactPerson.isAcceptableOrUnknown(
          data['contact_person']!,
          _contactPersonMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('payment_terms')) {
      context.handle(
        _paymentTermsMeta,
        paymentTerms.isAcceptableOrUnknown(
          data['payment_terms']!,
          _paymentTermsMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_person'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      paymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_terms'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String name;
  final String? contactPerson;
  final String? phone;
  final String? email;
  final String? address;
  final String paymentTerms;
  final String category;
  final bool isActive;
  final DateTime createdAt;
  const Supplier({
    required this.id,
    required this.name,
    this.contactPerson,
    this.phone,
    this.email,
    this.address,
    required this.paymentTerms,
    required this.category,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['payment_terms'] = Variable<String>(paymentTerms);
    map['category'] = Variable<String>(category);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      paymentTerms: Value(paymentTerms),
      category: Value(category),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      paymentTerms: serializer.fromJson<String>(json['paymentTerms']),
      category: serializer.fromJson<String>(json['category']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'paymentTerms': serializer.toJson<String>(paymentTerms),
      'category': serializer.toJson<String>(category),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Supplier copyWith({
    int? id,
    String? name,
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    String? paymentTerms,
    String? category,
    bool? isActive,
    DateTime? createdAt,
  }) => Supplier(
    id: id ?? this.id,
    name: name ?? this.name,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    paymentTerms: paymentTerms ?? this.paymentTerms,
    category: category ?? this.category,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      paymentTerms: data.paymentTerms.present
          ? data.paymentTerms.value
          : this.paymentTerms,
      category: data.category.present ? data.category.value : this.category,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    contactPerson,
    phone,
    email,
    address,
    paymentTerms,
    category,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactPerson == this.contactPerson &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.paymentTerms == this.paymentTerms &&
          other.category == this.category &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> contactPerson;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String> paymentTerms;
  final Value<String> category;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contactPerson,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? paymentTerms,
    Expression<String>? category,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (category != null) 'category': category,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? contactPerson,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String>? paymentTerms,
    Value<String>? category,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(paymentTerms.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _poNumberMeta = const VerificationMeta(
    'poNumber',
  );
  @override
  late final GeneratedColumn<String> poNumber = GeneratedColumn<String>(
    'po_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id)',
    ),
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _orderDateMeta = const VerificationMeta(
    'orderDate',
  );
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
    'order_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expectedDateMeta = const VerificationMeta(
    'expectedDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedDate = GeneratedColumn<DateTime>(
    'expected_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedDateMeta = const VerificationMeta(
    'receivedDate',
  );
  @override
  late final GeneratedColumn<DateTime> receivedDate = GeneratedColumn<DateTime>(
    'received_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    poNumber,
    supplierId,
    supplierName,
    status,
    totalAmount,
    orderDate,
    expectedDate,
    receivedDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('po_number')) {
      context.handle(
        _poNumberMeta,
        poNumber.isAcceptableOrUnknown(data['po_number']!, _poNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_poNumberMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('order_date')) {
      context.handle(
        _orderDateMeta,
        orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta),
      );
    }
    if (data.containsKey('expected_date')) {
      context.handle(
        _expectedDateMeta,
        expectedDate.isAcceptableOrUnknown(
          data['expected_date']!,
          _expectedDateMeta,
        ),
      );
    }
    if (data.containsKey('received_date')) {
      context.handle(
        _receivedDateMeta,
        receivedDate.isAcceptableOrUnknown(
          data['received_date']!,
          _receivedDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      poNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}po_number'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      orderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}order_date'],
      )!,
      expectedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_date'],
      ),
      receivedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

class PurchaseOrder extends DataClass implements Insertable<PurchaseOrder> {
  final int id;
  final String poNumber;
  final int supplierId;
  final String supplierName;
  final String status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? expectedDate;
  final DateTime? receivedDate;
  final String notes;
  const PurchaseOrder({
    required this.id,
    required this.poNumber,
    required this.supplierId,
    required this.supplierName,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.expectedDate,
    this.receivedDate,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['po_number'] = Variable<String>(poNumber);
    map['supplier_id'] = Variable<int>(supplierId);
    map['supplier_name'] = Variable<String>(supplierName);
    map['status'] = Variable<String>(status);
    map['total_amount'] = Variable<double>(totalAmount);
    map['order_date'] = Variable<DateTime>(orderDate);
    if (!nullToAbsent || expectedDate != null) {
      map['expected_date'] = Variable<DateTime>(expectedDate);
    }
    if (!nullToAbsent || receivedDate != null) {
      map['received_date'] = Variable<DateTime>(receivedDate);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      id: Value(id),
      poNumber: Value(poNumber),
      supplierId: Value(supplierId),
      supplierName: Value(supplierName),
      status: Value(status),
      totalAmount: Value(totalAmount),
      orderDate: Value(orderDate),
      expectedDate: expectedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDate),
      receivedDate: receivedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedDate),
      notes: Value(notes),
    );
  }

  factory PurchaseOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrder(
      id: serializer.fromJson<int>(json['id']),
      poNumber: serializer.fromJson<String>(json['poNumber']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      status: serializer.fromJson<String>(json['status']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      expectedDate: serializer.fromJson<DateTime?>(json['expectedDate']),
      receivedDate: serializer.fromJson<DateTime?>(json['receivedDate']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'poNumber': serializer.toJson<String>(poNumber),
      'supplierId': serializer.toJson<int>(supplierId),
      'supplierName': serializer.toJson<String>(supplierName),
      'status': serializer.toJson<String>(status),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'expectedDate': serializer.toJson<DateTime?>(expectedDate),
      'receivedDate': serializer.toJson<DateTime?>(receivedDate),
      'notes': serializer.toJson<String>(notes),
    };
  }

  PurchaseOrder copyWith({
    int? id,
    String? poNumber,
    int? supplierId,
    String? supplierName,
    String? status,
    double? totalAmount,
    DateTime? orderDate,
    Value<DateTime?> expectedDate = const Value.absent(),
    Value<DateTime?> receivedDate = const Value.absent(),
    String? notes,
  }) => PurchaseOrder(
    id: id ?? this.id,
    poNumber: poNumber ?? this.poNumber,
    supplierId: supplierId ?? this.supplierId,
    supplierName: supplierName ?? this.supplierName,
    status: status ?? this.status,
    totalAmount: totalAmount ?? this.totalAmount,
    orderDate: orderDate ?? this.orderDate,
    expectedDate: expectedDate.present ? expectedDate.value : this.expectedDate,
    receivedDate: receivedDate.present ? receivedDate.value : this.receivedDate,
    notes: notes ?? this.notes,
  );
  PurchaseOrder copyWithCompanion(PurchaseOrdersCompanion data) {
    return PurchaseOrder(
      id: data.id.present ? data.id.value : this.id,
      poNumber: data.poNumber.present ? data.poNumber.value : this.poNumber,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      status: data.status.present ? data.status.value : this.status,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      expectedDate: data.expectedDate.present
          ? data.expectedDate.value
          : this.expectedDate,
      receivedDate: data.receivedDate.present
          ? data.receivedDate.value
          : this.receivedDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrder(')
          ..write('id: $id, ')
          ..write('poNumber: $poNumber, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierName: $supplierName, ')
          ..write('status: $status, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('orderDate: $orderDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    poNumber,
    supplierId,
    supplierName,
    status,
    totalAmount,
    orderDate,
    expectedDate,
    receivedDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrder &&
          other.id == this.id &&
          other.poNumber == this.poNumber &&
          other.supplierId == this.supplierId &&
          other.supplierName == this.supplierName &&
          other.status == this.status &&
          other.totalAmount == this.totalAmount &&
          other.orderDate == this.orderDate &&
          other.expectedDate == this.expectedDate &&
          other.receivedDate == this.receivedDate &&
          other.notes == this.notes);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrder> {
  final Value<int> id;
  final Value<String> poNumber;
  final Value<int> supplierId;
  final Value<String> supplierName;
  final Value<String> status;
  final Value<double> totalAmount;
  final Value<DateTime> orderDate;
  final Value<DateTime?> expectedDate;
  final Value<DateTime?> receivedDate;
  final Value<String> notes;
  const PurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.poNumber = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.status = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.expectedDate = const Value.absent(),
    this.receivedDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String poNumber,
    required int supplierId,
    required String supplierName,
    this.status = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.expectedDate = const Value.absent(),
    this.receivedDate = const Value.absent(),
    this.notes = const Value.absent(),
  }) : poNumber = Value(poNumber),
       supplierId = Value(supplierId),
       supplierName = Value(supplierName);
  static Insertable<PurchaseOrder> custom({
    Expression<int>? id,
    Expression<String>? poNumber,
    Expression<int>? supplierId,
    Expression<String>? supplierName,
    Expression<String>? status,
    Expression<double>? totalAmount,
    Expression<DateTime>? orderDate,
    Expression<DateTime>? expectedDate,
    Expression<DateTime>? receivedDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (poNumber != null) 'po_number': poNumber,
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierName != null) 'supplier_name': supplierName,
      if (status != null) 'status': status,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (orderDate != null) 'order_date': orderDate,
      if (expectedDate != null) 'expected_date': expectedDate,
      if (receivedDate != null) 'received_date': receivedDate,
      if (notes != null) 'notes': notes,
    });
  }

  PurchaseOrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? poNumber,
    Value<int>? supplierId,
    Value<String>? supplierName,
    Value<String>? status,
    Value<double>? totalAmount,
    Value<DateTime>? orderDate,
    Value<DateTime?>? expectedDate,
    Value<DateTime?>? receivedDate,
    Value<String>? notes,
  }) {
    return PurchaseOrdersCompanion(
      id: id ?? this.id,
      poNumber: poNumber ?? this.poNumber,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      expectedDate: expectedDate ?? this.expectedDate,
      receivedDate: receivedDate ?? this.receivedDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (poNumber.present) {
      map['po_number'] = Variable<String>(poNumber.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (expectedDate.present) {
      map['expected_date'] = Variable<DateTime>(expectedDate.value);
    }
    if (receivedDate.present) {
      map['received_date'] = Variable<DateTime>(receivedDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('poNumber: $poNumber, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierName: $supplierName, ')
          ..write('status: $status, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('orderDate: $orderDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrderItemsTable extends PurchaseOrderItems
    with TableInfo<$PurchaseOrderItemsTable, PurchaseOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _poIdMeta = const VerificationMeta('poId');
  @override
  late final GeneratedColumn<int> poId = GeneratedColumn<int>(
    'po_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_orders (id)',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _ingredientNameMeta = const VerificationMeta(
    'ingredientName',
  );
  @override
  late final GeneratedColumn<String> ingredientName = GeneratedColumn<String>(
    'ingredient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unit'),
  );
  static const VerificationMeta _quantityOrderedMeta = const VerificationMeta(
    'quantityOrdered',
  );
  @override
  late final GeneratedColumn<double> quantityOrdered = GeneratedColumn<double>(
    'quantity_ordered',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _quantityReceivedMeta = const VerificationMeta(
    'quantityReceived',
  );
  @override
  late final GeneratedColumn<double> quantityReceived = GeneratedColumn<double>(
    'quantity_received',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    poId,
    ingredientId,
    ingredientName,
    unit,
    quantityOrdered,
    quantityReceived,
    unitCost,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('po_id')) {
      context.handle(
        _poIdMeta,
        poId.isAcceptableOrUnknown(data['po_id']!, _poIdMeta),
      );
    } else if (isInserting) {
      context.missing(_poIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('ingredient_name')) {
      context.handle(
        _ingredientNameMeta,
        ingredientName.isAcceptableOrUnknown(
          data['ingredient_name']!,
          _ingredientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientNameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('quantity_ordered')) {
      context.handle(
        _quantityOrderedMeta,
        quantityOrdered.isAcceptableOrUnknown(
          data['quantity_ordered']!,
          _quantityOrderedMeta,
        ),
      );
    }
    if (data.containsKey('quantity_received')) {
      context.handle(
        _quantityReceivedMeta,
        quantityReceived.isAcceptableOrUnknown(
          data['quantity_received']!,
          _quantityReceivedMeta,
        ),
      );
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      poId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}po_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      ingredientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      quantityOrdered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_ordered'],
      )!,
      quantityReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_received'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
    );
  }

  @override
  $PurchaseOrderItemsTable createAlias(String alias) {
    return $PurchaseOrderItemsTable(attachedDatabase, alias);
  }
}

class PurchaseOrderItem extends DataClass
    implements Insertable<PurchaseOrderItem> {
  final int id;
  final int poId;
  final int ingredientId;
  final String ingredientName;
  final String unit;
  final double quantityOrdered;
  final double quantityReceived;
  final double unitCost;
  final double subtotal;
  const PurchaseOrderItem({
    required this.id,
    required this.poId,
    required this.ingredientId,
    required this.ingredientName,
    required this.unit,
    required this.quantityOrdered,
    required this.quantityReceived,
    required this.unitCost,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['po_id'] = Variable<int>(poId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['ingredient_name'] = Variable<String>(ingredientName);
    map['unit'] = Variable<String>(unit);
    map['quantity_ordered'] = Variable<double>(quantityOrdered);
    map['quantity_received'] = Variable<double>(quantityReceived);
    map['unit_cost'] = Variable<double>(unitCost);
    map['subtotal'] = Variable<double>(subtotal);
    return map;
  }

  PurchaseOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrderItemsCompanion(
      id: Value(id),
      poId: Value(poId),
      ingredientId: Value(ingredientId),
      ingredientName: Value(ingredientName),
      unit: Value(unit),
      quantityOrdered: Value(quantityOrdered),
      quantityReceived: Value(quantityReceived),
      unitCost: Value(unitCost),
      subtotal: Value(subtotal),
    );
  }

  factory PurchaseOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderItem(
      id: serializer.fromJson<int>(json['id']),
      poId: serializer.fromJson<int>(json['poId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      ingredientName: serializer.fromJson<String>(json['ingredientName']),
      unit: serializer.fromJson<String>(json['unit']),
      quantityOrdered: serializer.fromJson<double>(json['quantityOrdered']),
      quantityReceived: serializer.fromJson<double>(json['quantityReceived']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'poId': serializer.toJson<int>(poId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'ingredientName': serializer.toJson<String>(ingredientName),
      'unit': serializer.toJson<String>(unit),
      'quantityOrdered': serializer.toJson<double>(quantityOrdered),
      'quantityReceived': serializer.toJson<double>(quantityReceived),
      'unitCost': serializer.toJson<double>(unitCost),
      'subtotal': serializer.toJson<double>(subtotal),
    };
  }

  PurchaseOrderItem copyWith({
    int? id,
    int? poId,
    int? ingredientId,
    String? ingredientName,
    String? unit,
    double? quantityOrdered,
    double? quantityReceived,
    double? unitCost,
    double? subtotal,
  }) => PurchaseOrderItem(
    id: id ?? this.id,
    poId: poId ?? this.poId,
    ingredientId: ingredientId ?? this.ingredientId,
    ingredientName: ingredientName ?? this.ingredientName,
    unit: unit ?? this.unit,
    quantityOrdered: quantityOrdered ?? this.quantityOrdered,
    quantityReceived: quantityReceived ?? this.quantityReceived,
    unitCost: unitCost ?? this.unitCost,
    subtotal: subtotal ?? this.subtotal,
  );
  PurchaseOrderItem copyWithCompanion(PurchaseOrderItemsCompanion data) {
    return PurchaseOrderItem(
      id: data.id.present ? data.id.value : this.id,
      poId: data.poId.present ? data.poId.value : this.poId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      ingredientName: data.ingredientName.present
          ? data.ingredientName.value
          : this.ingredientName,
      unit: data.unit.present ? data.unit.value : this.unit,
      quantityOrdered: data.quantityOrdered.present
          ? data.quantityOrdered.value
          : this.quantityOrdered,
      quantityReceived: data.quantityReceived.present
          ? data.quantityReceived.value
          : this.quantityReceived,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItem(')
          ..write('id: $id, ')
          ..write('poId: $poId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('ingredientName: $ingredientName, ')
          ..write('unit: $unit, ')
          ..write('quantityOrdered: $quantityOrdered, ')
          ..write('quantityReceived: $quantityReceived, ')
          ..write('unitCost: $unitCost, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    poId,
    ingredientId,
    ingredientName,
    unit,
    quantityOrdered,
    quantityReceived,
    unitCost,
    subtotal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderItem &&
          other.id == this.id &&
          other.poId == this.poId &&
          other.ingredientId == this.ingredientId &&
          other.ingredientName == this.ingredientName &&
          other.unit == this.unit &&
          other.quantityOrdered == this.quantityOrdered &&
          other.quantityReceived == this.quantityReceived &&
          other.unitCost == this.unitCost &&
          other.subtotal == this.subtotal);
}

class PurchaseOrderItemsCompanion extends UpdateCompanion<PurchaseOrderItem> {
  final Value<int> id;
  final Value<int> poId;
  final Value<int> ingredientId;
  final Value<String> ingredientName;
  final Value<String> unit;
  final Value<double> quantityOrdered;
  final Value<double> quantityReceived;
  final Value<double> unitCost;
  final Value<double> subtotal;
  const PurchaseOrderItemsCompanion({
    this.id = const Value.absent(),
    this.poId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.ingredientName = const Value.absent(),
    this.unit = const Value.absent(),
    this.quantityOrdered = const Value.absent(),
    this.quantityReceived = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  PurchaseOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int poId,
    required int ingredientId,
    required String ingredientName,
    this.unit = const Value.absent(),
    this.quantityOrdered = const Value.absent(),
    this.quantityReceived = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.subtotal = const Value.absent(),
  }) : poId = Value(poId),
       ingredientId = Value(ingredientId),
       ingredientName = Value(ingredientName);
  static Insertable<PurchaseOrderItem> custom({
    Expression<int>? id,
    Expression<int>? poId,
    Expression<int>? ingredientId,
    Expression<String>? ingredientName,
    Expression<String>? unit,
    Expression<double>? quantityOrdered,
    Expression<double>? quantityReceived,
    Expression<double>? unitCost,
    Expression<double>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (poId != null) 'po_id': poId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (ingredientName != null) 'ingredient_name': ingredientName,
      if (unit != null) 'unit': unit,
      if (quantityOrdered != null) 'quantity_ordered': quantityOrdered,
      if (quantityReceived != null) 'quantity_received': quantityReceived,
      if (unitCost != null) 'unit_cost': unitCost,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  PurchaseOrderItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? poId,
    Value<int>? ingredientId,
    Value<String>? ingredientName,
    Value<String>? unit,
    Value<double>? quantityOrdered,
    Value<double>? quantityReceived,
    Value<double>? unitCost,
    Value<double>? subtotal,
  }) {
    return PurchaseOrderItemsCompanion(
      id: id ?? this.id,
      poId: poId ?? this.poId,
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      unit: unit ?? this.unit,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      quantityReceived: quantityReceived ?? this.quantityReceived,
      unitCost: unitCost ?? this.unitCost,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (poId.present) {
      map['po_id'] = Variable<int>(poId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (ingredientName.present) {
      map['ingredient_name'] = Variable<String>(ingredientName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (quantityOrdered.present) {
      map['quantity_ordered'] = Variable<double>(quantityOrdered.value);
    }
    if (quantityReceived.present) {
      map['quantity_received'] = Variable<double>(quantityReceived.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('poId: $poId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('ingredientName: $ingredientName, ')
          ..write('unit: $unit, ')
          ..write('quantityOrdered: $quantityOrdered, ')
          ..write('quantityReceived: $quantityReceived, ')
          ..write('unitCost: $unitCost, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

class $StockAuditsTable extends StockAudits
    with TableInfo<$StockAuditsTable, StockAudit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAuditsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _ingredientNameMeta = const VerificationMeta(
    'ingredientName',
  );
  @override
  late final GeneratedColumn<String> ingredientName = GeneratedColumn<String>(
    'ingredient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unit'),
  );
  static const VerificationMeta _expectedStockMeta = const VerificationMeta(
    'expectedStock',
  );
  @override
  late final GeneratedColumn<double> expectedStock = GeneratedColumn<double>(
    'expected_stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _actualStockMeta = const VerificationMeta(
    'actualStock',
  );
  @override
  late final GeneratedColumn<double> actualStock = GeneratedColumn<double>(
    'actual_stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _varianceQuantityMeta = const VerificationMeta(
    'varianceQuantity',
  );
  @override
  late final GeneratedColumn<double> varianceQuantity = GeneratedColumn<double>(
    'variance_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _varianceValueMeta = const VerificationMeta(
    'varianceValue',
  );
  @override
  late final GeneratedColumn<double> varianceValue = GeneratedColumn<double>(
    'variance_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Routine Check'),
  );
  static const VerificationMeta _auditedByMeta = const VerificationMeta(
    'auditedBy',
  );
  @override
  late final GeneratedColumn<String> auditedBy = GeneratedColumn<String>(
    'audited_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Shift Manager'),
  );
  static const VerificationMeta _auditedAtMeta = const VerificationMeta(
    'auditedAt',
  );
  @override
  late final GeneratedColumn<DateTime> auditedAt = GeneratedColumn<DateTime>(
    'audited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ingredientId,
    ingredientName,
    unit,
    expectedStock,
    actualStock,
    varianceQuantity,
    varianceValue,
    reason,
    auditedBy,
    auditedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_audits';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockAudit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('ingredient_name')) {
      context.handle(
        _ingredientNameMeta,
        ingredientName.isAcceptableOrUnknown(
          data['ingredient_name']!,
          _ingredientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientNameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('expected_stock')) {
      context.handle(
        _expectedStockMeta,
        expectedStock.isAcceptableOrUnknown(
          data['expected_stock']!,
          _expectedStockMeta,
        ),
      );
    }
    if (data.containsKey('actual_stock')) {
      context.handle(
        _actualStockMeta,
        actualStock.isAcceptableOrUnknown(
          data['actual_stock']!,
          _actualStockMeta,
        ),
      );
    }
    if (data.containsKey('variance_quantity')) {
      context.handle(
        _varianceQuantityMeta,
        varianceQuantity.isAcceptableOrUnknown(
          data['variance_quantity']!,
          _varianceQuantityMeta,
        ),
      );
    }
    if (data.containsKey('variance_value')) {
      context.handle(
        _varianceValueMeta,
        varianceValue.isAcceptableOrUnknown(
          data['variance_value']!,
          _varianceValueMeta,
        ),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('audited_by')) {
      context.handle(
        _auditedByMeta,
        auditedBy.isAcceptableOrUnknown(data['audited_by']!, _auditedByMeta),
      );
    }
    if (data.containsKey('audited_at')) {
      context.handle(
        _auditedAtMeta,
        auditedAt.isAcceptableOrUnknown(data['audited_at']!, _auditedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockAudit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAudit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      ingredientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      expectedStock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_stock'],
      )!,
      actualStock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_stock'],
      )!,
      varianceQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}variance_quantity'],
      )!,
      varianceValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}variance_value'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      auditedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audited_by'],
      )!,
      auditedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}audited_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $StockAuditsTable createAlias(String alias) {
    return $StockAuditsTable(attachedDatabase, alias);
  }
}

class StockAudit extends DataClass implements Insertable<StockAudit> {
  final int id;
  final int ingredientId;
  final String ingredientName;
  final String unit;
  final double expectedStock;
  final double actualStock;
  final double varianceQuantity;
  final double varianceValue;
  final String reason;
  final String auditedBy;
  final DateTime auditedAt;
  final String notes;
  const StockAudit({
    required this.id,
    required this.ingredientId,
    required this.ingredientName,
    required this.unit,
    required this.expectedStock,
    required this.actualStock,
    required this.varianceQuantity,
    required this.varianceValue,
    required this.reason,
    required this.auditedBy,
    required this.auditedAt,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['ingredient_name'] = Variable<String>(ingredientName);
    map['unit'] = Variable<String>(unit);
    map['expected_stock'] = Variable<double>(expectedStock);
    map['actual_stock'] = Variable<double>(actualStock);
    map['variance_quantity'] = Variable<double>(varianceQuantity);
    map['variance_value'] = Variable<double>(varianceValue);
    map['reason'] = Variable<String>(reason);
    map['audited_by'] = Variable<String>(auditedBy);
    map['audited_at'] = Variable<DateTime>(auditedAt);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  StockAuditsCompanion toCompanion(bool nullToAbsent) {
    return StockAuditsCompanion(
      id: Value(id),
      ingredientId: Value(ingredientId),
      ingredientName: Value(ingredientName),
      unit: Value(unit),
      expectedStock: Value(expectedStock),
      actualStock: Value(actualStock),
      varianceQuantity: Value(varianceQuantity),
      varianceValue: Value(varianceValue),
      reason: Value(reason),
      auditedBy: Value(auditedBy),
      auditedAt: Value(auditedAt),
      notes: Value(notes),
    );
  }

  factory StockAudit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAudit(
      id: serializer.fromJson<int>(json['id']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      ingredientName: serializer.fromJson<String>(json['ingredientName']),
      unit: serializer.fromJson<String>(json['unit']),
      expectedStock: serializer.fromJson<double>(json['expectedStock']),
      actualStock: serializer.fromJson<double>(json['actualStock']),
      varianceQuantity: serializer.fromJson<double>(json['varianceQuantity']),
      varianceValue: serializer.fromJson<double>(json['varianceValue']),
      reason: serializer.fromJson<String>(json['reason']),
      auditedBy: serializer.fromJson<String>(json['auditedBy']),
      auditedAt: serializer.fromJson<DateTime>(json['auditedAt']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'ingredientName': serializer.toJson<String>(ingredientName),
      'unit': serializer.toJson<String>(unit),
      'expectedStock': serializer.toJson<double>(expectedStock),
      'actualStock': serializer.toJson<double>(actualStock),
      'varianceQuantity': serializer.toJson<double>(varianceQuantity),
      'varianceValue': serializer.toJson<double>(varianceValue),
      'reason': serializer.toJson<String>(reason),
      'auditedBy': serializer.toJson<String>(auditedBy),
      'auditedAt': serializer.toJson<DateTime>(auditedAt),
      'notes': serializer.toJson<String>(notes),
    };
  }

  StockAudit copyWith({
    int? id,
    int? ingredientId,
    String? ingredientName,
    String? unit,
    double? expectedStock,
    double? actualStock,
    double? varianceQuantity,
    double? varianceValue,
    String? reason,
    String? auditedBy,
    DateTime? auditedAt,
    String? notes,
  }) => StockAudit(
    id: id ?? this.id,
    ingredientId: ingredientId ?? this.ingredientId,
    ingredientName: ingredientName ?? this.ingredientName,
    unit: unit ?? this.unit,
    expectedStock: expectedStock ?? this.expectedStock,
    actualStock: actualStock ?? this.actualStock,
    varianceQuantity: varianceQuantity ?? this.varianceQuantity,
    varianceValue: varianceValue ?? this.varianceValue,
    reason: reason ?? this.reason,
    auditedBy: auditedBy ?? this.auditedBy,
    auditedAt: auditedAt ?? this.auditedAt,
    notes: notes ?? this.notes,
  );
  StockAudit copyWithCompanion(StockAuditsCompanion data) {
    return StockAudit(
      id: data.id.present ? data.id.value : this.id,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      ingredientName: data.ingredientName.present
          ? data.ingredientName.value
          : this.ingredientName,
      unit: data.unit.present ? data.unit.value : this.unit,
      expectedStock: data.expectedStock.present
          ? data.expectedStock.value
          : this.expectedStock,
      actualStock: data.actualStock.present
          ? data.actualStock.value
          : this.actualStock,
      varianceQuantity: data.varianceQuantity.present
          ? data.varianceQuantity.value
          : this.varianceQuantity,
      varianceValue: data.varianceValue.present
          ? data.varianceValue.value
          : this.varianceValue,
      reason: data.reason.present ? data.reason.value : this.reason,
      auditedBy: data.auditedBy.present ? data.auditedBy.value : this.auditedBy,
      auditedAt: data.auditedAt.present ? data.auditedAt.value : this.auditedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAudit(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('ingredientName: $ingredientName, ')
          ..write('unit: $unit, ')
          ..write('expectedStock: $expectedStock, ')
          ..write('actualStock: $actualStock, ')
          ..write('varianceQuantity: $varianceQuantity, ')
          ..write('varianceValue: $varianceValue, ')
          ..write('reason: $reason, ')
          ..write('auditedBy: $auditedBy, ')
          ..write('auditedAt: $auditedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ingredientId,
    ingredientName,
    unit,
    expectedStock,
    actualStock,
    varianceQuantity,
    varianceValue,
    reason,
    auditedBy,
    auditedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAudit &&
          other.id == this.id &&
          other.ingredientId == this.ingredientId &&
          other.ingredientName == this.ingredientName &&
          other.unit == this.unit &&
          other.expectedStock == this.expectedStock &&
          other.actualStock == this.actualStock &&
          other.varianceQuantity == this.varianceQuantity &&
          other.varianceValue == this.varianceValue &&
          other.reason == this.reason &&
          other.auditedBy == this.auditedBy &&
          other.auditedAt == this.auditedAt &&
          other.notes == this.notes);
}

class StockAuditsCompanion extends UpdateCompanion<StockAudit> {
  final Value<int> id;
  final Value<int> ingredientId;
  final Value<String> ingredientName;
  final Value<String> unit;
  final Value<double> expectedStock;
  final Value<double> actualStock;
  final Value<double> varianceQuantity;
  final Value<double> varianceValue;
  final Value<String> reason;
  final Value<String> auditedBy;
  final Value<DateTime> auditedAt;
  final Value<String> notes;
  const StockAuditsCompanion({
    this.id = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.ingredientName = const Value.absent(),
    this.unit = const Value.absent(),
    this.expectedStock = const Value.absent(),
    this.actualStock = const Value.absent(),
    this.varianceQuantity = const Value.absent(),
    this.varianceValue = const Value.absent(),
    this.reason = const Value.absent(),
    this.auditedBy = const Value.absent(),
    this.auditedAt = const Value.absent(),
    this.notes = const Value.absent(),
  });
  StockAuditsCompanion.insert({
    this.id = const Value.absent(),
    required int ingredientId,
    required String ingredientName,
    this.unit = const Value.absent(),
    this.expectedStock = const Value.absent(),
    this.actualStock = const Value.absent(),
    this.varianceQuantity = const Value.absent(),
    this.varianceValue = const Value.absent(),
    this.reason = const Value.absent(),
    this.auditedBy = const Value.absent(),
    this.auditedAt = const Value.absent(),
    this.notes = const Value.absent(),
  }) : ingredientId = Value(ingredientId),
       ingredientName = Value(ingredientName);
  static Insertable<StockAudit> custom({
    Expression<int>? id,
    Expression<int>? ingredientId,
    Expression<String>? ingredientName,
    Expression<String>? unit,
    Expression<double>? expectedStock,
    Expression<double>? actualStock,
    Expression<double>? varianceQuantity,
    Expression<double>? varianceValue,
    Expression<String>? reason,
    Expression<String>? auditedBy,
    Expression<DateTime>? auditedAt,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (ingredientName != null) 'ingredient_name': ingredientName,
      if (unit != null) 'unit': unit,
      if (expectedStock != null) 'expected_stock': expectedStock,
      if (actualStock != null) 'actual_stock': actualStock,
      if (varianceQuantity != null) 'variance_quantity': varianceQuantity,
      if (varianceValue != null) 'variance_value': varianceValue,
      if (reason != null) 'reason': reason,
      if (auditedBy != null) 'audited_by': auditedBy,
      if (auditedAt != null) 'audited_at': auditedAt,
      if (notes != null) 'notes': notes,
    });
  }

  StockAuditsCompanion copyWith({
    Value<int>? id,
    Value<int>? ingredientId,
    Value<String>? ingredientName,
    Value<String>? unit,
    Value<double>? expectedStock,
    Value<double>? actualStock,
    Value<double>? varianceQuantity,
    Value<double>? varianceValue,
    Value<String>? reason,
    Value<String>? auditedBy,
    Value<DateTime>? auditedAt,
    Value<String>? notes,
  }) {
    return StockAuditsCompanion(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      unit: unit ?? this.unit,
      expectedStock: expectedStock ?? this.expectedStock,
      actualStock: actualStock ?? this.actualStock,
      varianceQuantity: varianceQuantity ?? this.varianceQuantity,
      varianceValue: varianceValue ?? this.varianceValue,
      reason: reason ?? this.reason,
      auditedBy: auditedBy ?? this.auditedBy,
      auditedAt: auditedAt ?? this.auditedAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (ingredientName.present) {
      map['ingredient_name'] = Variable<String>(ingredientName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (expectedStock.present) {
      map['expected_stock'] = Variable<double>(expectedStock.value);
    }
    if (actualStock.present) {
      map['actual_stock'] = Variable<double>(actualStock.value);
    }
    if (varianceQuantity.present) {
      map['variance_quantity'] = Variable<double>(varianceQuantity.value);
    }
    if (varianceValue.present) {
      map['variance_value'] = Variable<double>(varianceValue.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (auditedBy.present) {
      map['audited_by'] = Variable<String>(auditedBy.value);
    }
    if (auditedAt.present) {
      map['audited_at'] = Variable<DateTime>(auditedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAuditsCompanion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('ingredientName: $ingredientName, ')
          ..write('unit: $unit, ')
          ..write('expectedStock: $expectedStock, ')
          ..write('actualStock: $actualStock, ')
          ..write('varianceQuantity: $varianceQuantity, ')
          ..write('varianceValue: $varianceValue, ')
          ..write('reason: $reason, ')
          ..write('auditedBy: $auditedBy, ')
          ..write('auditedAt: $auditedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Petty Cash'),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _recipientMeta = const VerificationMeta(
    'recipient',
  );
  @override
  late final GeneratedColumn<String> recipient = GeneratedColumn<String>(
    'recipient',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _receiptNumberMeta = const VerificationMeta(
    'receiptNumber',
  );
  @override
  late final GeneratedColumn<String> receiptNumber = GeneratedColumn<String>(
    'receipt_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedByMeta = const VerificationMeta(
    'recordedBy',
  );
  @override
  late final GeneratedColumn<String> recordedBy = GeneratedColumn<String>(
    'recorded_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Staff'),
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    amount,
    paymentMethod,
    recipient,
    description,
    receiptNumber,
    recordedBy,
    expenseDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('recipient')) {
      context.handle(
        _recipientMeta,
        recipient.isAcceptableOrUnknown(data['recipient']!, _recipientMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('receipt_number')) {
      context.handle(
        _receiptNumberMeta,
        receiptNumber.isAcceptableOrUnknown(
          data['receipt_number']!,
          _receiptNumberMeta,
        ),
      );
    }
    if (data.containsKey('recorded_by')) {
      context.handle(
        _recordedByMeta,
        recordedBy.isAcceptableOrUnknown(data['recorded_by']!, _recordedByMeta),
      );
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      recipient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      receiptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_number'],
      ),
      recordedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recorded_by'],
      )!,
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String category;
  final double amount;
  final String paymentMethod;
  final String recipient;
  final String description;
  final String? receiptNumber;
  final String recordedBy;
  final DateTime expenseDate;
  const Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.paymentMethod,
    required this.recipient,
    required this.description,
    this.receiptNumber,
    required this.recordedBy,
    required this.expenseDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['recipient'] = Variable<String>(recipient);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || receiptNumber != null) {
      map['receipt_number'] = Variable<String>(receiptNumber);
    }
    map['recorded_by'] = Variable<String>(recordedBy);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      category: Value(category),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      recipient: Value(recipient),
      description: Value(description),
      receiptNumber: receiptNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptNumber),
      recordedBy: Value(recordedBy),
      expenseDate: Value(expenseDate),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      recipient: serializer.fromJson<String>(json['recipient']),
      description: serializer.fromJson<String>(json['description']),
      receiptNumber: serializer.fromJson<String?>(json['receiptNumber']),
      recordedBy: serializer.fromJson<String>(json['recordedBy']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'recipient': serializer.toJson<String>(recipient),
      'description': serializer.toJson<String>(description),
      'receiptNumber': serializer.toJson<String?>(receiptNumber),
      'recordedBy': serializer.toJson<String>(recordedBy),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
    };
  }

  Expense copyWith({
    int? id,
    String? category,
    double? amount,
    String? paymentMethod,
    String? recipient,
    String? description,
    Value<String?> receiptNumber = const Value.absent(),
    String? recordedBy,
    DateTime? expenseDate,
  }) => Expense(
    id: id ?? this.id,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    recipient: recipient ?? this.recipient,
    description: description ?? this.description,
    receiptNumber: receiptNumber.present
        ? receiptNumber.value
        : this.receiptNumber,
    recordedBy: recordedBy ?? this.recordedBy,
    expenseDate: expenseDate ?? this.expenseDate,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      recipient: data.recipient.present ? data.recipient.value : this.recipient,
      description: data.description.present
          ? data.description.value
          : this.description,
      receiptNumber: data.receiptNumber.present
          ? data.receiptNumber.value
          : this.receiptNumber,
      recordedBy: data.recordedBy.present
          ? data.recordedBy.value
          : this.recordedBy,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('recipient: $recipient, ')
          ..write('description: $description, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('expenseDate: $expenseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    amount,
    paymentMethod,
    recipient,
    description,
    receiptNumber,
    recordedBy,
    expenseDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.recipient == this.recipient &&
          other.description == this.description &&
          other.receiptNumber == this.receiptNumber &&
          other.recordedBy == this.recordedBy &&
          other.expenseDate == this.expenseDate);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> category;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<String> recipient;
  final Value<String> description;
  final Value<String?> receiptNumber;
  final Value<String> recordedBy;
  final Value<DateTime> expenseDate;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.recipient = const Value.absent(),
    this.description = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.recordedBy = const Value.absent(),
    this.expenseDate = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.recipient = const Value.absent(),
    this.description = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.recordedBy = const Value.absent(),
    this.expenseDate = const Value.absent(),
  });
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? recipient,
    Expression<String>? description,
    Expression<String>? receiptNumber,
    Expression<String>? recordedBy,
    Expression<DateTime>? expenseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (recipient != null) 'recipient': recipient,
      if (description != null) 'description': description,
      if (receiptNumber != null) 'receipt_number': receiptNumber,
      if (recordedBy != null) 'recorded_by': recordedBy,
      if (expenseDate != null) 'expense_date': expenseDate,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<String>? recipient,
    Value<String>? description,
    Value<String?>? receiptNumber,
    Value<String>? recordedBy,
    Value<DateTime>? expenseDate,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      recipient: recipient ?? this.recipient,
      description: description ?? this.description,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      recordedBy: recordedBy ?? this.recordedBy,
      expenseDate: expenseDate ?? this.expenseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (recipient.present) {
      map['recipient'] = Variable<String>(recipient.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (receiptNumber.present) {
      map['receipt_number'] = Variable<String>(receiptNumber.value);
    }
    if (recordedBy.present) {
      map['recorded_by'] = Variable<String>(recordedBy.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('recipient: $recipient, ')
          ..write('description: $description, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('expenseDate: $expenseDate')
          ..write(')'))
        .toString();
  }
}

class $CashDrawerLogsTable extends CashDrawerLogs
    with TableInfo<$CashDrawerLogsTable, CashDrawerLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashDrawerLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _recordedByMeta = const VerificationMeta(
    'recordedBy',
  );
  @override
  late final GeneratedColumn<String> recordedBy = GeneratedColumn<String>(
    'recorded_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Staff'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    amount,
    reason,
    recordedBy,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_drawer_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashDrawerLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('recorded_by')) {
      context.handle(
        _recordedByMeta,
        recordedBy.isAcceptableOrUnknown(data['recorded_by']!, _recordedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashDrawerLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashDrawerLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      recordedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recorded_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CashDrawerLogsTable createAlias(String alias) {
    return $CashDrawerLogsTable(attachedDatabase, alias);
  }
}

class CashDrawerLog extends DataClass implements Insertable<CashDrawerLog> {
  final int id;
  final String type;
  final double amount;
  final String reason;
  final String recordedBy;
  final DateTime createdAt;
  const CashDrawerLog({
    required this.id,
    required this.type,
    required this.amount,
    required this.reason,
    required this.recordedBy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['reason'] = Variable<String>(reason);
    map['recorded_by'] = Variable<String>(recordedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashDrawerLogsCompanion toCompanion(bool nullToAbsent) {
    return CashDrawerLogsCompanion(
      id: Value(id),
      type: Value(type),
      amount: Value(amount),
      reason: Value(reason),
      recordedBy: Value(recordedBy),
      createdAt: Value(createdAt),
    );
  }

  factory CashDrawerLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashDrawerLog(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String>(json['reason']),
      recordedBy: serializer.fromJson<String>(json['recordedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String>(reason),
      'recordedBy': serializer.toJson<String>(recordedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashDrawerLog copyWith({
    int? id,
    String? type,
    double? amount,
    String? reason,
    String? recordedBy,
    DateTime? createdAt,
  }) => CashDrawerLog(
    id: id ?? this.id,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    reason: reason ?? this.reason,
    recordedBy: recordedBy ?? this.recordedBy,
    createdAt: createdAt ?? this.createdAt,
  );
  CashDrawerLog copyWithCompanion(CashDrawerLogsCompanion data) {
    return CashDrawerLog(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      recordedBy: data.recordedBy.present
          ? data.recordedBy.value
          : this.recordedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashDrawerLog(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, amount, reason, recordedBy, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashDrawerLog &&
          other.id == this.id &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.recordedBy == this.recordedBy &&
          other.createdAt == this.createdAt);
}

class CashDrawerLogsCompanion extends UpdateCompanion<CashDrawerLog> {
  final Value<int> id;
  final Value<String> type;
  final Value<double> amount;
  final Value<String> reason;
  final Value<String> recordedBy;
  final Value<DateTime> createdAt;
  const CashDrawerLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.recordedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CashDrawerLogsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.recordedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type);
  static Insertable<CashDrawerLog> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<String>? recordedBy,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (recordedBy != null) 'recorded_by': recordedBy,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CashDrawerLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<double>? amount,
    Value<String>? reason,
    Value<String>? recordedBy,
    Value<DateTime>? createdAt,
  }) {
    return CashDrawerLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      recordedBy: recordedBy ?? this.recordedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (recordedBy.present) {
      map['recorded_by'] = Variable<String>(recordedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashDrawerLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('recordedBy: $recordedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncTombstonesTable extends SyncTombstones
    with TableInfo<$SyncTombstonesTable, SyncTombstone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncTombstonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordKeyMeta = const VerificationMeta(
    'recordKey',
  );
  @override
  late final GeneratedColumn<String> recordKey = GeneratedColumn<String>(
    'record_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetTable,
    recordKey,
    deletedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_tombstones';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncTombstone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_key')) {
      context.handle(
        _recordKeyMeta,
        recordKey.isAcceptableOrUnknown(data['record_key']!, _recordKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_recordKeyMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncTombstone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncTombstone(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      recordKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_key'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $SyncTombstonesTable createAlias(String alias) {
    return $SyncTombstonesTable(attachedDatabase, alias);
  }
}

class SyncTombstone extends DataClass implements Insertable<SyncTombstone> {
  final int id;
  final String targetTable;
  final String recordKey;
  final DateTime deletedAt;
  final bool isSynced;
  const SyncTombstone({
    required this.id,
    required this.targetTable,
    required this.recordKey,
    required this.deletedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['record_key'] = Variable<String>(recordKey);
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SyncTombstonesCompanion toCompanion(bool nullToAbsent) {
    return SyncTombstonesCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordKey: Value(recordKey),
      deletedAt: Value(deletedAt),
      isSynced: Value(isSynced),
    );
  }

  factory SyncTombstone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncTombstone(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordKey: serializer.fromJson<String>(json['recordKey']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordKey': serializer.toJson<String>(recordKey),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SyncTombstone copyWith({
    int? id,
    String? targetTable,
    String? recordKey,
    DateTime? deletedAt,
    bool? isSynced,
  }) => SyncTombstone(
    id: id ?? this.id,
    targetTable: targetTable ?? this.targetTable,
    recordKey: recordKey ?? this.recordKey,
    deletedAt: deletedAt ?? this.deletedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  SyncTombstone copyWithCompanion(SyncTombstonesCompanion data) {
    return SyncTombstone(
      id: data.id.present ? data.id.value : this.id,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      recordKey: data.recordKey.present ? data.recordKey.value : this.recordKey,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncTombstone(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordKey: $recordKey, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, targetTable, recordKey, deletedAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncTombstone &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordKey == this.recordKey &&
          other.deletedAt == this.deletedAt &&
          other.isSynced == this.isSynced);
}

class SyncTombstonesCompanion extends UpdateCompanion<SyncTombstone> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> recordKey;
  final Value<DateTime> deletedAt;
  final Value<bool> isSynced;
  const SyncTombstonesCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordKey = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  SyncTombstonesCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String recordKey,
    this.deletedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : targetTable = Value(targetTable),
       recordKey = Value(recordKey);
  static Insertable<SyncTombstone> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? recordKey,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (recordKey != null) 'record_key': recordKey,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  SyncTombstonesCompanion copyWith({
    Value<int>? id,
    Value<String>? targetTable,
    Value<String>? recordKey,
    Value<DateTime>? deletedAt,
    Value<bool>? isSynced,
  }) {
    return SyncTombstonesCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordKey: recordKey ?? this.recordKey,
      deletedAt: deletedAt ?? this.deletedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (recordKey.present) {
      map['record_key'] = Variable<String>(recordKey.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncTombstonesCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordKey: $recordKey, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $OutletsTable extends Outlets with TableInfo<$OutletsTable, Outlet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priceMultiplierMeta = const VerificationMeta(
    'priceMultiplier',
  );
  @override
  late final GeneratedColumn<double> priceMultiplier = GeneratedColumn<double>(
    'price_multiplier',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    code,
    address,
    phone,
    isPrimary,
    priceMultiplier,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outlets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Outlet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('price_multiplier')) {
      context.handle(
        _priceMultiplierMeta,
        priceMultiplier.isAcceptableOrUnknown(
          data['price_multiplier']!,
          _priceMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Outlet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Outlet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      priceMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_multiplier'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OutletsTable createAlias(String alias) {
    return $OutletsTable(attachedDatabase, alias);
  }
}

class Outlet extends DataClass implements Insertable<Outlet> {
  final int id;
  final String name;
  final String code;
  final String address;
  final String phone;
  final bool isPrimary;
  final double priceMultiplier;
  final DateTime createdAt;
  const Outlet({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.phone,
    required this.isPrimary,
    required this.priceMultiplier,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    map['address'] = Variable<String>(address);
    map['phone'] = Variable<String>(phone);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['price_multiplier'] = Variable<double>(priceMultiplier);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OutletsCompanion toCompanion(bool nullToAbsent) {
    return OutletsCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      address: Value(address),
      phone: Value(phone),
      isPrimary: Value(isPrimary),
      priceMultiplier: Value(priceMultiplier),
      createdAt: Value(createdAt),
    );
  }

  factory Outlet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Outlet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      address: serializer.fromJson<String>(json['address']),
      phone: serializer.fromJson<String>(json['phone']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      priceMultiplier: serializer.fromJson<double>(json['priceMultiplier']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'address': serializer.toJson<String>(address),
      'phone': serializer.toJson<String>(phone),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'priceMultiplier': serializer.toJson<double>(priceMultiplier),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Outlet copyWith({
    int? id,
    String? name,
    String? code,
    String? address,
    String? phone,
    bool? isPrimary,
    double? priceMultiplier,
    DateTime? createdAt,
  }) => Outlet(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    address: address ?? this.address,
    phone: phone ?? this.phone,
    isPrimary: isPrimary ?? this.isPrimary,
    priceMultiplier: priceMultiplier ?? this.priceMultiplier,
    createdAt: createdAt ?? this.createdAt,
  );
  Outlet copyWithCompanion(OutletsCompanion data) {
    return Outlet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      priceMultiplier: data.priceMultiplier.present
          ? data.priceMultiplier.value
          : this.priceMultiplier,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Outlet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('priceMultiplier: $priceMultiplier, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    code,
    address,
    phone,
    isPrimary,
    priceMultiplier,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Outlet &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.isPrimary == this.isPrimary &&
          other.priceMultiplier == this.priceMultiplier &&
          other.createdAt == this.createdAt);
}

class OutletsCompanion extends UpdateCompanion<Outlet> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> code;
  final Value<String> address;
  final Value<String> phone;
  final Value<bool> isPrimary;
  final Value<double> priceMultiplier;
  final Value<DateTime> createdAt;
  const OutletsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.priceMultiplier = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OutletsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String code,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.priceMultiplier = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       code = Value(code);
  static Insertable<Outlet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<bool>? isPrimary,
    Expression<double>? priceMultiplier,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (priceMultiplier != null) 'price_multiplier': priceMultiplier,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OutletsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? code,
    Value<String>? address,
    Value<String>? phone,
    Value<bool>? isPrimary,
    Value<double>? priceMultiplier,
    Value<DateTime>? createdAt,
  }) {
    return OutletsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      isPrimary: isPrimary ?? this.isPrimary,
      priceMultiplier: priceMultiplier ?? this.priceMultiplier,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (priceMultiplier.present) {
      map['price_multiplier'] = Variable<double>(priceMultiplier.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutletsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('priceMultiplier: $priceMultiplier, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StockTransfersTable extends StockTransfers
    with TableInfo<$StockTransfersTable, StockTransfer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _transferNumberMeta = const VerificationMeta(
    'transferNumber',
  );
  @override
  late final GeneratedColumn<String> transferNumber = GeneratedColumn<String>(
    'transfer_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceOutletIdMeta = const VerificationMeta(
    'sourceOutletId',
  );
  @override
  late final GeneratedColumn<int> sourceOutletId = GeneratedColumn<int>(
    'source_outlet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetOutletIdMeta = const VerificationMeta(
    'targetOutletId',
  );
  @override
  late final GeneratedColumn<int> targetOutletId = GeneratedColumn<int>(
    'target_outlet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _requestedByMeta = const VerificationMeta(
    'requestedBy',
  );
  @override
  late final GeneratedColumn<String> requestedBy = GeneratedColumn<String>(
    'requested_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Manager'),
  );
  static const VerificationMeta _transferDateMeta = const VerificationMeta(
    'transferDate',
  );
  @override
  late final GeneratedColumn<DateTime> transferDate = GeneratedColumn<DateTime>(
    'transfer_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transferNumber,
    sourceOutletId,
    targetOutletId,
    ingredientId,
    quantity,
    status,
    requestedBy,
    transferDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockTransfer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transfer_number')) {
      context.handle(
        _transferNumberMeta,
        transferNumber.isAcceptableOrUnknown(
          data['transfer_number']!,
          _transferNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transferNumberMeta);
    }
    if (data.containsKey('source_outlet_id')) {
      context.handle(
        _sourceOutletIdMeta,
        sourceOutletId.isAcceptableOrUnknown(
          data['source_outlet_id']!,
          _sourceOutletIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceOutletIdMeta);
    }
    if (data.containsKey('target_outlet_id')) {
      context.handle(
        _targetOutletIdMeta,
        targetOutletId.isAcceptableOrUnknown(
          data['target_outlet_id']!,
          _targetOutletIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetOutletIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('requested_by')) {
      context.handle(
        _requestedByMeta,
        requestedBy.isAcceptableOrUnknown(
          data['requested_by']!,
          _requestedByMeta,
        ),
      );
    }
    if (data.containsKey('transfer_date')) {
      context.handle(
        _transferDateMeta,
        transferDate.isAcceptableOrUnknown(
          data['transfer_date']!,
          _transferDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTransfer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransfer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      transferNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_number'],
      )!,
      sourceOutletId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_outlet_id'],
      )!,
      targetOutletId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_outlet_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      requestedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requested_by'],
      )!,
      transferDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transfer_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $StockTransfersTable createAlias(String alias) {
    return $StockTransfersTable(attachedDatabase, alias);
  }
}

class StockTransfer extends DataClass implements Insertable<StockTransfer> {
  final int id;
  final String transferNumber;
  final int sourceOutletId;
  final int targetOutletId;
  final int ingredientId;
  final double quantity;
  final String status;
  final String requestedBy;
  final DateTime transferDate;
  final String notes;
  const StockTransfer({
    required this.id,
    required this.transferNumber,
    required this.sourceOutletId,
    required this.targetOutletId,
    required this.ingredientId,
    required this.quantity,
    required this.status,
    required this.requestedBy,
    required this.transferDate,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transfer_number'] = Variable<String>(transferNumber);
    map['source_outlet_id'] = Variable<int>(sourceOutletId);
    map['target_outlet_id'] = Variable<int>(targetOutletId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['quantity'] = Variable<double>(quantity);
    map['status'] = Variable<String>(status);
    map['requested_by'] = Variable<String>(requestedBy);
    map['transfer_date'] = Variable<DateTime>(transferDate);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  StockTransfersCompanion toCompanion(bool nullToAbsent) {
    return StockTransfersCompanion(
      id: Value(id),
      transferNumber: Value(transferNumber),
      sourceOutletId: Value(sourceOutletId),
      targetOutletId: Value(targetOutletId),
      ingredientId: Value(ingredientId),
      quantity: Value(quantity),
      status: Value(status),
      requestedBy: Value(requestedBy),
      transferDate: Value(transferDate),
      notes: Value(notes),
    );
  }

  factory StockTransfer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransfer(
      id: serializer.fromJson<int>(json['id']),
      transferNumber: serializer.fromJson<String>(json['transferNumber']),
      sourceOutletId: serializer.fromJson<int>(json['sourceOutletId']),
      targetOutletId: serializer.fromJson<int>(json['targetOutletId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      status: serializer.fromJson<String>(json['status']),
      requestedBy: serializer.fromJson<String>(json['requestedBy']),
      transferDate: serializer.fromJson<DateTime>(json['transferDate']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transferNumber': serializer.toJson<String>(transferNumber),
      'sourceOutletId': serializer.toJson<int>(sourceOutletId),
      'targetOutletId': serializer.toJson<int>(targetOutletId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'quantity': serializer.toJson<double>(quantity),
      'status': serializer.toJson<String>(status),
      'requestedBy': serializer.toJson<String>(requestedBy),
      'transferDate': serializer.toJson<DateTime>(transferDate),
      'notes': serializer.toJson<String>(notes),
    };
  }

  StockTransfer copyWith({
    int? id,
    String? transferNumber,
    int? sourceOutletId,
    int? targetOutletId,
    int? ingredientId,
    double? quantity,
    String? status,
    String? requestedBy,
    DateTime? transferDate,
    String? notes,
  }) => StockTransfer(
    id: id ?? this.id,
    transferNumber: transferNumber ?? this.transferNumber,
    sourceOutletId: sourceOutletId ?? this.sourceOutletId,
    targetOutletId: targetOutletId ?? this.targetOutletId,
    ingredientId: ingredientId ?? this.ingredientId,
    quantity: quantity ?? this.quantity,
    status: status ?? this.status,
    requestedBy: requestedBy ?? this.requestedBy,
    transferDate: transferDate ?? this.transferDate,
    notes: notes ?? this.notes,
  );
  StockTransfer copyWithCompanion(StockTransfersCompanion data) {
    return StockTransfer(
      id: data.id.present ? data.id.value : this.id,
      transferNumber: data.transferNumber.present
          ? data.transferNumber.value
          : this.transferNumber,
      sourceOutletId: data.sourceOutletId.present
          ? data.sourceOutletId.value
          : this.sourceOutletId,
      targetOutletId: data.targetOutletId.present
          ? data.targetOutletId.value
          : this.targetOutletId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      status: data.status.present ? data.status.value : this.status,
      requestedBy: data.requestedBy.present
          ? data.requestedBy.value
          : this.requestedBy,
      transferDate: data.transferDate.present
          ? data.transferDate.value
          : this.transferDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTransfer(')
          ..write('id: $id, ')
          ..write('transferNumber: $transferNumber, ')
          ..write('sourceOutletId: $sourceOutletId, ')
          ..write('targetOutletId: $targetOutletId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('requestedBy: $requestedBy, ')
          ..write('transferDate: $transferDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transferNumber,
    sourceOutletId,
    targetOutletId,
    ingredientId,
    quantity,
    status,
    requestedBy,
    transferDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTransfer &&
          other.id == this.id &&
          other.transferNumber == this.transferNumber &&
          other.sourceOutletId == this.sourceOutletId &&
          other.targetOutletId == this.targetOutletId &&
          other.ingredientId == this.ingredientId &&
          other.quantity == this.quantity &&
          other.status == this.status &&
          other.requestedBy == this.requestedBy &&
          other.transferDate == this.transferDate &&
          other.notes == this.notes);
}

class StockTransfersCompanion extends UpdateCompanion<StockTransfer> {
  final Value<int> id;
  final Value<String> transferNumber;
  final Value<int> sourceOutletId;
  final Value<int> targetOutletId;
  final Value<int> ingredientId;
  final Value<double> quantity;
  final Value<String> status;
  final Value<String> requestedBy;
  final Value<DateTime> transferDate;
  final Value<String> notes;
  const StockTransfersCompanion({
    this.id = const Value.absent(),
    this.transferNumber = const Value.absent(),
    this.sourceOutletId = const Value.absent(),
    this.targetOutletId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.requestedBy = const Value.absent(),
    this.transferDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  StockTransfersCompanion.insert({
    this.id = const Value.absent(),
    required String transferNumber,
    required int sourceOutletId,
    required int targetOutletId,
    required int ingredientId,
    required double quantity,
    this.status = const Value.absent(),
    this.requestedBy = const Value.absent(),
    this.transferDate = const Value.absent(),
    this.notes = const Value.absent(),
  }) : transferNumber = Value(transferNumber),
       sourceOutletId = Value(sourceOutletId),
       targetOutletId = Value(targetOutletId),
       ingredientId = Value(ingredientId),
       quantity = Value(quantity);
  static Insertable<StockTransfer> custom({
    Expression<int>? id,
    Expression<String>? transferNumber,
    Expression<int>? sourceOutletId,
    Expression<int>? targetOutletId,
    Expression<int>? ingredientId,
    Expression<double>? quantity,
    Expression<String>? status,
    Expression<String>? requestedBy,
    Expression<DateTime>? transferDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transferNumber != null) 'transfer_number': transferNumber,
      if (sourceOutletId != null) 'source_outlet_id': sourceOutletId,
      if (targetOutletId != null) 'target_outlet_id': targetOutletId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (quantity != null) 'quantity': quantity,
      if (status != null) 'status': status,
      if (requestedBy != null) 'requested_by': requestedBy,
      if (transferDate != null) 'transfer_date': transferDate,
      if (notes != null) 'notes': notes,
    });
  }

  StockTransfersCompanion copyWith({
    Value<int>? id,
    Value<String>? transferNumber,
    Value<int>? sourceOutletId,
    Value<int>? targetOutletId,
    Value<int>? ingredientId,
    Value<double>? quantity,
    Value<String>? status,
    Value<String>? requestedBy,
    Value<DateTime>? transferDate,
    Value<String>? notes,
  }) {
    return StockTransfersCompanion(
      id: id ?? this.id,
      transferNumber: transferNumber ?? this.transferNumber,
      sourceOutletId: sourceOutletId ?? this.sourceOutletId,
      targetOutletId: targetOutletId ?? this.targetOutletId,
      ingredientId: ingredientId ?? this.ingredientId,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      requestedBy: requestedBy ?? this.requestedBy,
      transferDate: transferDate ?? this.transferDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transferNumber.present) {
      map['transfer_number'] = Variable<String>(transferNumber.value);
    }
    if (sourceOutletId.present) {
      map['source_outlet_id'] = Variable<int>(sourceOutletId.value);
    }
    if (targetOutletId.present) {
      map['target_outlet_id'] = Variable<int>(targetOutletId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (requestedBy.present) {
      map['requested_by'] = Variable<String>(requestedBy.value);
    }
    if (transferDate.present) {
      map['transfer_date'] = Variable<DateTime>(transferDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockTransfersCompanion(')
          ..write('id: $id, ')
          ..write('transferNumber: $transferNumber, ')
          ..write('sourceOutletId: $sourceOutletId, ')
          ..write('targetOutletId: $targetOutletId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('requestedBy: $requestedBy, ')
          ..write('transferDate: $transferDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $DeliveryOrdersTable extends DeliveryOrders
    with TableInfo<$DeliveryOrdersTable, DeliveryOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformOrderIdMeta = const VerificationMeta(
    'platformOrderId',
  );
  @override
  late final GeneratedColumn<String> platformOrderId = GeneratedColumn<String>(
    'platform_order_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commissionRateMeta = const VerificationMeta(
    'commissionRate',
  );
  @override
  late final GeneratedColumn<double> commissionRate = GeneratedColumn<double>(
    'commission_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.30),
  );
  static const VerificationMeta _commissionAmountMeta = const VerificationMeta(
    'commissionAmount',
  );
  @override
  late final GeneratedColumn<double> commissionAmount = GeneratedColumn<double>(
    'commission_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _netPayoutMeta = const VerificationMeta(
    'netPayout',
  );
  @override
  late final GeneratedColumn<double> netPayout = GeneratedColumn<double>(
    'net_payout',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _riderNameMeta = const VerificationMeta(
    'riderName',
  );
  @override
  late final GeneratedColumn<String> riderName = GeneratedColumn<String>(
    'rider_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riderPhoneMeta = const VerificationMeta(
    'riderPhone',
  );
  @override
  late final GeneratedColumn<String> riderPhone = GeneratedColumn<String>(
    'rider_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pickupStatusMeta = const VerificationMeta(
    'pickupStatus',
  );
  @override
  late final GeneratedColumn<String> pickupStatus = GeneratedColumn<String>(
    'pickup_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _estimatedPickupTimeMeta =
      const VerificationMeta('estimatedPickupTime');
  @override
  late final GeneratedColumn<DateTime> estimatedPickupTime =
      GeneratedColumn<DateTime>(
        'estimated_pickup_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    channel,
    platformOrderId,
    commissionRate,
    commissionAmount,
    netPayout,
    riderName,
    riderPhone,
    pickupStatus,
    estimatedPickupTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'delivery_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeliveryOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    } else if (isInserting) {
      context.missing(_channelMeta);
    }
    if (data.containsKey('platform_order_id')) {
      context.handle(
        _platformOrderIdMeta,
        platformOrderId.isAcceptableOrUnknown(
          data['platform_order_id']!,
          _platformOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformOrderIdMeta);
    }
    if (data.containsKey('commission_rate')) {
      context.handle(
        _commissionRateMeta,
        commissionRate.isAcceptableOrUnknown(
          data['commission_rate']!,
          _commissionRateMeta,
        ),
      );
    }
    if (data.containsKey('commission_amount')) {
      context.handle(
        _commissionAmountMeta,
        commissionAmount.isAcceptableOrUnknown(
          data['commission_amount']!,
          _commissionAmountMeta,
        ),
      );
    }
    if (data.containsKey('net_payout')) {
      context.handle(
        _netPayoutMeta,
        netPayout.isAcceptableOrUnknown(data['net_payout']!, _netPayoutMeta),
      );
    }
    if (data.containsKey('rider_name')) {
      context.handle(
        _riderNameMeta,
        riderName.isAcceptableOrUnknown(data['rider_name']!, _riderNameMeta),
      );
    }
    if (data.containsKey('rider_phone')) {
      context.handle(
        _riderPhoneMeta,
        riderPhone.isAcceptableOrUnknown(data['rider_phone']!, _riderPhoneMeta),
      );
    }
    if (data.containsKey('pickup_status')) {
      context.handle(
        _pickupStatusMeta,
        pickupStatus.isAcceptableOrUnknown(
          data['pickup_status']!,
          _pickupStatusMeta,
        ),
      );
    }
    if (data.containsKey('estimated_pickup_time')) {
      context.handle(
        _estimatedPickupTimeMeta,
        estimatedPickupTime.isAcceptableOrUnknown(
          data['estimated_pickup_time']!,
          _estimatedPickupTimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      )!,
      platformOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_order_id'],
      )!,
      commissionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_rate'],
      )!,
      commissionAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_amount'],
      )!,
      netPayout: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_payout'],
      )!,
      riderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rider_name'],
      ),
      riderPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rider_phone'],
      ),
      pickupStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pickup_status'],
      )!,
      estimatedPickupTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}estimated_pickup_time'],
      ),
    );
  }

  @override
  $DeliveryOrdersTable createAlias(String alias) {
    return $DeliveryOrdersTable(attachedDatabase, alias);
  }
}

class DeliveryOrder extends DataClass implements Insertable<DeliveryOrder> {
  final int id;
  final int orderId;
  final String channel;
  final String platformOrderId;
  final double commissionRate;
  final double commissionAmount;
  final double netPayout;
  final String? riderName;
  final String? riderPhone;
  final String pickupStatus;
  final DateTime? estimatedPickupTime;
  const DeliveryOrder({
    required this.id,
    required this.orderId,
    required this.channel,
    required this.platformOrderId,
    required this.commissionRate,
    required this.commissionAmount,
    required this.netPayout,
    this.riderName,
    this.riderPhone,
    required this.pickupStatus,
    this.estimatedPickupTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['channel'] = Variable<String>(channel);
    map['platform_order_id'] = Variable<String>(platformOrderId);
    map['commission_rate'] = Variable<double>(commissionRate);
    map['commission_amount'] = Variable<double>(commissionAmount);
    map['net_payout'] = Variable<double>(netPayout);
    if (!nullToAbsent || riderName != null) {
      map['rider_name'] = Variable<String>(riderName);
    }
    if (!nullToAbsent || riderPhone != null) {
      map['rider_phone'] = Variable<String>(riderPhone);
    }
    map['pickup_status'] = Variable<String>(pickupStatus);
    if (!nullToAbsent || estimatedPickupTime != null) {
      map['estimated_pickup_time'] = Variable<DateTime>(estimatedPickupTime);
    }
    return map;
  }

  DeliveryOrdersCompanion toCompanion(bool nullToAbsent) {
    return DeliveryOrdersCompanion(
      id: Value(id),
      orderId: Value(orderId),
      channel: Value(channel),
      platformOrderId: Value(platformOrderId),
      commissionRate: Value(commissionRate),
      commissionAmount: Value(commissionAmount),
      netPayout: Value(netPayout),
      riderName: riderName == null && nullToAbsent
          ? const Value.absent()
          : Value(riderName),
      riderPhone: riderPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(riderPhone),
      pickupStatus: Value(pickupStatus),
      estimatedPickupTime: estimatedPickupTime == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedPickupTime),
    );
  }

  factory DeliveryOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryOrder(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      channel: serializer.fromJson<String>(json['channel']),
      platformOrderId: serializer.fromJson<String>(json['platformOrderId']),
      commissionRate: serializer.fromJson<double>(json['commissionRate']),
      commissionAmount: serializer.fromJson<double>(json['commissionAmount']),
      netPayout: serializer.fromJson<double>(json['netPayout']),
      riderName: serializer.fromJson<String?>(json['riderName']),
      riderPhone: serializer.fromJson<String?>(json['riderPhone']),
      pickupStatus: serializer.fromJson<String>(json['pickupStatus']),
      estimatedPickupTime: serializer.fromJson<DateTime?>(
        json['estimatedPickupTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'channel': serializer.toJson<String>(channel),
      'platformOrderId': serializer.toJson<String>(platformOrderId),
      'commissionRate': serializer.toJson<double>(commissionRate),
      'commissionAmount': serializer.toJson<double>(commissionAmount),
      'netPayout': serializer.toJson<double>(netPayout),
      'riderName': serializer.toJson<String?>(riderName),
      'riderPhone': serializer.toJson<String?>(riderPhone),
      'pickupStatus': serializer.toJson<String>(pickupStatus),
      'estimatedPickupTime': serializer.toJson<DateTime?>(estimatedPickupTime),
    };
  }

  DeliveryOrder copyWith({
    int? id,
    int? orderId,
    String? channel,
    String? platformOrderId,
    double? commissionRate,
    double? commissionAmount,
    double? netPayout,
    Value<String?> riderName = const Value.absent(),
    Value<String?> riderPhone = const Value.absent(),
    String? pickupStatus,
    Value<DateTime?> estimatedPickupTime = const Value.absent(),
  }) => DeliveryOrder(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    channel: channel ?? this.channel,
    platformOrderId: platformOrderId ?? this.platformOrderId,
    commissionRate: commissionRate ?? this.commissionRate,
    commissionAmount: commissionAmount ?? this.commissionAmount,
    netPayout: netPayout ?? this.netPayout,
    riderName: riderName.present ? riderName.value : this.riderName,
    riderPhone: riderPhone.present ? riderPhone.value : this.riderPhone,
    pickupStatus: pickupStatus ?? this.pickupStatus,
    estimatedPickupTime: estimatedPickupTime.present
        ? estimatedPickupTime.value
        : this.estimatedPickupTime,
  );
  DeliveryOrder copyWithCompanion(DeliveryOrdersCompanion data) {
    return DeliveryOrder(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      channel: data.channel.present ? data.channel.value : this.channel,
      platformOrderId: data.platformOrderId.present
          ? data.platformOrderId.value
          : this.platformOrderId,
      commissionRate: data.commissionRate.present
          ? data.commissionRate.value
          : this.commissionRate,
      commissionAmount: data.commissionAmount.present
          ? data.commissionAmount.value
          : this.commissionAmount,
      netPayout: data.netPayout.present ? data.netPayout.value : this.netPayout,
      riderName: data.riderName.present ? data.riderName.value : this.riderName,
      riderPhone: data.riderPhone.present
          ? data.riderPhone.value
          : this.riderPhone,
      pickupStatus: data.pickupStatus.present
          ? data.pickupStatus.value
          : this.pickupStatus,
      estimatedPickupTime: data.estimatedPickupTime.present
          ? data.estimatedPickupTime.value
          : this.estimatedPickupTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryOrder(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('channel: $channel, ')
          ..write('platformOrderId: $platformOrderId, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('commissionAmount: $commissionAmount, ')
          ..write('netPayout: $netPayout, ')
          ..write('riderName: $riderName, ')
          ..write('riderPhone: $riderPhone, ')
          ..write('pickupStatus: $pickupStatus, ')
          ..write('estimatedPickupTime: $estimatedPickupTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    channel,
    platformOrderId,
    commissionRate,
    commissionAmount,
    netPayout,
    riderName,
    riderPhone,
    pickupStatus,
    estimatedPickupTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryOrder &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.channel == this.channel &&
          other.platformOrderId == this.platformOrderId &&
          other.commissionRate == this.commissionRate &&
          other.commissionAmount == this.commissionAmount &&
          other.netPayout == this.netPayout &&
          other.riderName == this.riderName &&
          other.riderPhone == this.riderPhone &&
          other.pickupStatus == this.pickupStatus &&
          other.estimatedPickupTime == this.estimatedPickupTime);
}

class DeliveryOrdersCompanion extends UpdateCompanion<DeliveryOrder> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> channel;
  final Value<String> platformOrderId;
  final Value<double> commissionRate;
  final Value<double> commissionAmount;
  final Value<double> netPayout;
  final Value<String?> riderName;
  final Value<String?> riderPhone;
  final Value<String> pickupStatus;
  final Value<DateTime?> estimatedPickupTime;
  const DeliveryOrdersCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.channel = const Value.absent(),
    this.platformOrderId = const Value.absent(),
    this.commissionRate = const Value.absent(),
    this.commissionAmount = const Value.absent(),
    this.netPayout = const Value.absent(),
    this.riderName = const Value.absent(),
    this.riderPhone = const Value.absent(),
    this.pickupStatus = const Value.absent(),
    this.estimatedPickupTime = const Value.absent(),
  });
  DeliveryOrdersCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String channel,
    required String platformOrderId,
    this.commissionRate = const Value.absent(),
    this.commissionAmount = const Value.absent(),
    this.netPayout = const Value.absent(),
    this.riderName = const Value.absent(),
    this.riderPhone = const Value.absent(),
    this.pickupStatus = const Value.absent(),
    this.estimatedPickupTime = const Value.absent(),
  }) : orderId = Value(orderId),
       channel = Value(channel),
       platformOrderId = Value(platformOrderId);
  static Insertable<DeliveryOrder> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? channel,
    Expression<String>? platformOrderId,
    Expression<double>? commissionRate,
    Expression<double>? commissionAmount,
    Expression<double>? netPayout,
    Expression<String>? riderName,
    Expression<String>? riderPhone,
    Expression<String>? pickupStatus,
    Expression<DateTime>? estimatedPickupTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (channel != null) 'channel': channel,
      if (platformOrderId != null) 'platform_order_id': platformOrderId,
      if (commissionRate != null) 'commission_rate': commissionRate,
      if (commissionAmount != null) 'commission_amount': commissionAmount,
      if (netPayout != null) 'net_payout': netPayout,
      if (riderName != null) 'rider_name': riderName,
      if (riderPhone != null) 'rider_phone': riderPhone,
      if (pickupStatus != null) 'pickup_status': pickupStatus,
      if (estimatedPickupTime != null)
        'estimated_pickup_time': estimatedPickupTime,
    });
  }

  DeliveryOrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<String>? channel,
    Value<String>? platformOrderId,
    Value<double>? commissionRate,
    Value<double>? commissionAmount,
    Value<double>? netPayout,
    Value<String?>? riderName,
    Value<String?>? riderPhone,
    Value<String>? pickupStatus,
    Value<DateTime?>? estimatedPickupTime,
  }) {
    return DeliveryOrdersCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      channel: channel ?? this.channel,
      platformOrderId: platformOrderId ?? this.platformOrderId,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionAmount: commissionAmount ?? this.commissionAmount,
      netPayout: netPayout ?? this.netPayout,
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      pickupStatus: pickupStatus ?? this.pickupStatus,
      estimatedPickupTime: estimatedPickupTime ?? this.estimatedPickupTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (platformOrderId.present) {
      map['platform_order_id'] = Variable<String>(platformOrderId.value);
    }
    if (commissionRate.present) {
      map['commission_rate'] = Variable<double>(commissionRate.value);
    }
    if (commissionAmount.present) {
      map['commission_amount'] = Variable<double>(commissionAmount.value);
    }
    if (netPayout.present) {
      map['net_payout'] = Variable<double>(netPayout.value);
    }
    if (riderName.present) {
      map['rider_name'] = Variable<String>(riderName.value);
    }
    if (riderPhone.present) {
      map['rider_phone'] = Variable<String>(riderPhone.value);
    }
    if (pickupStatus.present) {
      map['pickup_status'] = Variable<String>(pickupStatus.value);
    }
    if (estimatedPickupTime.present) {
      map['estimated_pickup_time'] = Variable<DateTime>(
        estimatedPickupTime.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryOrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('channel: $channel, ')
          ..write('platformOrderId: $platformOrderId, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('commissionAmount: $commissionAmount, ')
          ..write('netPayout: $netPayout, ')
          ..write('riderName: $riderName, ')
          ..write('riderPhone: $riderPhone, ')
          ..write('pickupStatus: $pickupStatus, ')
          ..write('estimatedPickupTime: $estimatedPickupTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $MenuItemsTable menuItems = $MenuItemsTable(this);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $MenuItemIngredientsTable menuItemIngredients =
      $MenuItemIngredientsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $StaffMembersTable staffMembers = $StaffMembersTable(this);
  late final $StaffAttendancesTable staffAttendances = $StaffAttendancesTable(
    this,
  );
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final $PurchaseOrderItemsTable purchaseOrderItems =
      $PurchaseOrderItemsTable(this);
  late final $StockAuditsTable stockAudits = $StockAuditsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $CashDrawerLogsTable cashDrawerLogs = $CashDrawerLogsTable(this);
  late final $SyncTombstonesTable syncTombstones = $SyncTombstonesTable(this);
  late final $OutletsTable outlets = $OutletsTable(this);
  late final $StockTransfersTable stockTransfers = $StockTransfersTable(this);
  late final $DeliveryOrdersTable deliveryOrders = $DeliveryOrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    menuItems,
    ingredients,
    menuItemIngredients,
    orders,
    orderItems,
    tasks,
    customers,
    staffMembers,
    staffAttendances,
    suppliers,
    purchaseOrders,
    purchaseOrderItems,
    stockAudits,
    expenses,
    cashDrawerLogs,
    syncTombstones,
    outlets,
    stockTransfers,
    deliveryOrders,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<String> iconCode,
      Value<String> colorHex,
      Value<int> sortOrder,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> iconCode,
      Value<String> colorHex,
      Value<int> sortOrder,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenuItemsTable, List<MenuItem>>
  _menuItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuItems,
    aliasName: $_aliasNameGenerator(db.categories.id, db.menuItems.categoryId),
  );

  $$MenuItemsTableProcessedTableManager get menuItemsRefs {
    final manager = $$MenuItemsTableTableManager(
      $_db,
      $_db.menuItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconCode => $composableBuilder(
    column: $table.iconCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menuItemsRefs(
    Expression<bool> Function($$MenuItemsTableFilterComposer f) f,
  ) {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableFilterComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconCode => $composableBuilder(
    column: $table.iconCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconCode =>
      $composableBuilder(column: $table.iconCode, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> menuItemsRefs<T extends Object>(
    Expression<T> Function($$MenuItemsTableAnnotationComposer a) f,
  ) {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool menuItemsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> iconCode = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                iconCode: iconCode,
                colorHex: colorHex,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> iconCode = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                iconCode: iconCode,
                colorHex: colorHex,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (menuItemsRefs) db.menuItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (menuItemsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      MenuItem
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._menuItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).menuItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool menuItemsRefs})
    >;
typedef $$MenuItemsTableCreateCompanionBuilder =
    MenuItemsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String> description,
      required double basePrice,
      Value<String?> imageUrl,
      Value<bool> isAvailable,
      Value<String> preparationStation,
    });
typedef $$MenuItemsTableUpdateCompanionBuilder =
    MenuItemsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String> description,
      Value<double> basePrice,
      Value<String?> imageUrl,
      Value<bool> isAvailable,
      Value<String> preparationStation,
    });

final class $$MenuItemsTableReferences
    extends BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem> {
  $$MenuItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.menuItems.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $MenuItemIngredientsTable,
    List<MenuItemIngredient>
  >
  _menuItemIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.menuItemIngredients,
        aliasName: $_aliasNameGenerator(
          db.menuItems.id,
          db.menuItemIngredients.menuItemId,
        ),
      );

  $$MenuItemIngredientsTableProcessedTableManager get menuItemIngredientsRefs {
    final manager = $$MenuItemIngredientsTableTableManager(
      $_db,
      $_db.menuItemIngredients,
    ).filter((f) => f.menuItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _menuItemIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
  _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItems,
    aliasName: $_aliasNameGenerator(db.menuItems.id, db.orderItems.menuItemId),
  );

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.menuItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MenuItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preparationStation => $composableBuilder(
    column: $table.preparationStation,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> menuItemIngredientsRefs(
    Expression<bool> Function($$MenuItemIngredientsTableFilterComposer f) f,
  ) {
    final $$MenuItemIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuItemIngredients,
      getReferencedColumn: (t) => t.menuItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.menuItemIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> orderItemsRefs(
    Expression<bool> Function($$OrderItemsTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.menuItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenuItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preparationStation => $composableBuilder(
    column: $table.preparationStation,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get basePrice =>
      $composableBuilder(column: $table.basePrice, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preparationStation => $composableBuilder(
    column: $table.preparationStation,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> menuItemIngredientsRefs<T extends Object>(
    Expression<T> Function($$MenuItemIngredientsTableAnnotationComposer a) f,
  ) {
    final $$MenuItemIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.menuItemIngredients,
          getReferencedColumn: (t) => t.menuItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MenuItemIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.menuItemIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> orderItemsRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.menuItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenuItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuItemsTable,
          MenuItem,
          $$MenuItemsTableFilterComposer,
          $$MenuItemsTableOrderingComposer,
          $$MenuItemsTableAnnotationComposer,
          $$MenuItemsTableCreateCompanionBuilder,
          $$MenuItemsTableUpdateCompanionBuilder,
          (MenuItem, $$MenuItemsTableReferences),
          MenuItem,
          PrefetchHooks Function({
            bool categoryId,
            bool menuItemIngredientsRefs,
            bool orderItemsRefs,
          })
        > {
  $$MenuItemsTableTableManager(_$AppDatabase db, $MenuItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> basePrice = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String> preparationStation = const Value.absent(),
              }) => MenuItemsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                basePrice: basePrice,
                imageUrl: imageUrl,
                isAvailable: isAvailable,
                preparationStation: preparationStation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String> description = const Value.absent(),
                required double basePrice,
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String> preparationStation = const Value.absent(),
              }) => MenuItemsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                basePrice: basePrice,
                imageUrl: imageUrl,
                isAvailable: isAvailable,
                preparationStation: preparationStation,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MenuItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                menuItemIngredientsRefs = false,
                orderItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (menuItemIngredientsRefs) db.menuItemIngredients,
                    if (orderItemsRefs) db.orderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$MenuItemsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$MenuItemsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (menuItemIngredientsRefs)
                        await $_getPrefetchedData<
                          MenuItem,
                          $MenuItemsTable,
                          MenuItemIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$MenuItemsTableReferences
                              ._menuItemIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenuItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).menuItemIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.menuItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (orderItemsRefs)
                        await $_getPrefetchedData<
                          MenuItem,
                          $MenuItemsTable,
                          OrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$MenuItemsTableReferences
                              ._orderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MenuItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).orderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.menuItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MenuItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuItemsTable,
      MenuItem,
      $$MenuItemsTableFilterComposer,
      $$MenuItemsTableOrderingComposer,
      $$MenuItemsTableAnnotationComposer,
      $$MenuItemsTableCreateCompanionBuilder,
      $$MenuItemsTableUpdateCompanionBuilder,
      (MenuItem, $$MenuItemsTableReferences),
      MenuItem,
      PrefetchHooks Function({
        bool categoryId,
        bool menuItemIngredientsRefs,
        bool orderItemsRefs,
      })
    >;
typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      required String name,
      required String unit,
      Value<double> currentStock,
      Value<double> reorderPoint,
      Value<double> costPerUnit,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> unit,
      Value<double> currentStock,
      Value<double> reorderPoint,
      Value<double> costPerUnit,
    });

final class $$IngredientsTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient> {
  $$IngredientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $MenuItemIngredientsTable,
    List<MenuItemIngredient>
  >
  _menuItemIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.menuItemIngredients,
        aliasName: $_aliasNameGenerator(
          db.ingredients.id,
          db.menuItemIngredients.ingredientId,
        ),
      );

  $$MenuItemIngredientsTableProcessedTableManager get menuItemIngredientsRefs {
    final manager = $$MenuItemIngredientsTableTableManager(
      $_db,
      $_db.menuItemIngredients,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _menuItemIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseOrderItemsTable, List<PurchaseOrderItem>>
  _purchaseOrderItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrderItems,
        aliasName: $_aliasNameGenerator(
          db.ingredients.id,
          db.purchaseOrderItems.ingredientId,
        ),
      );

  $$PurchaseOrderItemsTableProcessedTableManager get purchaseOrderItemsRefs {
    final manager = $$PurchaseOrderItemsTableTableManager(
      $_db,
      $_db.purchaseOrderItems,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockAuditsTable, List<StockAudit>>
  _stockAuditsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockAudits,
    aliasName: $_aliasNameGenerator(
      db.ingredients.id,
      db.stockAudits.ingredientId,
    ),
  );

  $$StockAuditsTableProcessedTableManager get stockAuditsRefs {
    final manager = $$StockAuditsTableTableManager(
      $_db,
      $_db.stockAudits,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockAuditsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menuItemIngredientsRefs(
    Expression<bool> Function($$MenuItemIngredientsTableFilterComposer f) f,
  ) {
    final $$MenuItemIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuItemIngredients,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.menuItemIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseOrderItemsRefs(
    Expression<bool> Function($$PurchaseOrderItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrderItems,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockAuditsRefs(
    Expression<bool> Function($$StockAuditsTableFilterComposer f) f,
  ) {
    final $$StockAuditsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAudits,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockAuditsTableFilterComposer(
            $db: $db,
            $table: $db.stockAudits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => column,
  );

  Expression<T> menuItemIngredientsRefs<T extends Object>(
    Expression<T> Function($$MenuItemIngredientsTableAnnotationComposer a) f,
  ) {
    final $$MenuItemIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.menuItemIngredients,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MenuItemIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.menuItemIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> purchaseOrderItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrderItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseOrderItems,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrderItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrderItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> stockAuditsRefs<T extends Object>(
    Expression<T> Function($$StockAuditsTableAnnotationComposer a) f,
  ) {
    final $$StockAuditsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAudits,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockAuditsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockAudits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          Ingredient,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (Ingredient, $$IngredientsTableReferences),
          Ingredient,
          PrefetchHooks Function({
            bool menuItemIngredientsRefs,
            bool purchaseOrderItemsRefs,
            bool stockAuditsRefs,
          })
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> currentStock = const Value.absent(),
                Value<double> reorderPoint = const Value.absent(),
                Value<double> costPerUnit = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                name: name,
                unit: unit,
                currentStock: currentStock,
                reorderPoint: reorderPoint,
                costPerUnit: costPerUnit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String unit,
                Value<double> currentStock = const Value.absent(),
                Value<double> reorderPoint = const Value.absent(),
                Value<double> costPerUnit = const Value.absent(),
              }) => IngredientsCompanion.insert(
                id: id,
                name: name,
                unit: unit,
                currentStock: currentStock,
                reorderPoint: reorderPoint,
                costPerUnit: costPerUnit,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                menuItemIngredientsRefs = false,
                purchaseOrderItemsRefs = false,
                stockAuditsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (menuItemIngredientsRefs) db.menuItemIngredients,
                    if (purchaseOrderItemsRefs) db.purchaseOrderItems,
                    if (stockAuditsRefs) db.stockAudits,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (menuItemIngredientsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          MenuItemIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._menuItemIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).menuItemIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseOrderItemsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          PurchaseOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._purchaseOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockAuditsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          StockAudit
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._stockAuditsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockAuditsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      Ingredient,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (Ingredient, $$IngredientsTableReferences),
      Ingredient,
      PrefetchHooks Function({
        bool menuItemIngredientsRefs,
        bool purchaseOrderItemsRefs,
        bool stockAuditsRefs,
      })
    >;
typedef $$MenuItemIngredientsTableCreateCompanionBuilder =
    MenuItemIngredientsCompanion Function({
      required int menuItemId,
      required int ingredientId,
      required double quantityRequired,
      Value<int> rowid,
    });
typedef $$MenuItemIngredientsTableUpdateCompanionBuilder =
    MenuItemIngredientsCompanion Function({
      Value<int> menuItemId,
      Value<int> ingredientId,
      Value<double> quantityRequired,
      Value<int> rowid,
    });

final class $$MenuItemIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MenuItemIngredientsTable,
          MenuItemIngredient
        > {
  $$MenuItemIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MenuItemsTable _menuItemIdTable(_$AppDatabase db) =>
      db.menuItems.createAlias(
        $_aliasNameGenerator(
          db.menuItemIngredients.menuItemId,
          db.menuItems.id,
        ),
      );

  $$MenuItemsTableProcessedTableManager get menuItemId {
    final $_column = $_itemColumn<int>('menu_item_id')!;

    final manager = $$MenuItemsTableTableManager(
      $_db,
      $_db.menuItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(
          db.menuItemIngredients.ingredientId,
          db.ingredients.id,
        ),
      );

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MenuItemIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemIngredientsTable> {
  $$MenuItemIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get quantityRequired => $composableBuilder(
    column: $table.quantityRequired,
    builder: (column) => ColumnFilters(column),
  );

  $$MenuItemsTableFilterComposer get menuItemId {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableFilterComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuItemIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemIngredientsTable> {
  $$MenuItemIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get quantityRequired => $composableBuilder(
    column: $table.quantityRequired,
    builder: (column) => ColumnOrderings(column),
  );

  $$MenuItemsTableOrderingComposer get menuItemId {
    final $$MenuItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableOrderingComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuItemIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemIngredientsTable> {
  $$MenuItemIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get quantityRequired => $composableBuilder(
    column: $table.quantityRequired,
    builder: (column) => column,
  );

  $$MenuItemsTableAnnotationComposer get menuItemId {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuItemIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuItemIngredientsTable,
          MenuItemIngredient,
          $$MenuItemIngredientsTableFilterComposer,
          $$MenuItemIngredientsTableOrderingComposer,
          $$MenuItemIngredientsTableAnnotationComposer,
          $$MenuItemIngredientsTableCreateCompanionBuilder,
          $$MenuItemIngredientsTableUpdateCompanionBuilder,
          (MenuItemIngredient, $$MenuItemIngredientsTableReferences),
          MenuItemIngredient,
          PrefetchHooks Function({bool menuItemId, bool ingredientId})
        > {
  $$MenuItemIngredientsTableTableManager(
    _$AppDatabase db,
    $MenuItemIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemIngredientsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MenuItemIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> menuItemId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> quantityRequired = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MenuItemIngredientsCompanion(
                menuItemId: menuItemId,
                ingredientId: ingredientId,
                quantityRequired: quantityRequired,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int menuItemId,
                required int ingredientId,
                required double quantityRequired,
                Value<int> rowid = const Value.absent(),
              }) => MenuItemIngredientsCompanion.insert(
                menuItemId: menuItemId,
                ingredientId: ingredientId,
                quantityRequired: quantityRequired,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MenuItemIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuItemId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.menuItemId,
                                referencedTable:
                                    $$MenuItemIngredientsTableReferences
                                        ._menuItemIdTable(db),
                                referencedColumn:
                                    $$MenuItemIngredientsTableReferences
                                        ._menuItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$MenuItemIngredientsTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$MenuItemIngredientsTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MenuItemIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuItemIngredientsTable,
      MenuItemIngredient,
      $$MenuItemIngredientsTableFilterComposer,
      $$MenuItemIngredientsTableOrderingComposer,
      $$MenuItemIngredientsTableAnnotationComposer,
      $$MenuItemIngredientsTableCreateCompanionBuilder,
      $$MenuItemIngredientsTableUpdateCompanionBuilder,
      (MenuItemIngredient, $$MenuItemIngredientsTableReferences),
      MenuItemIngredient,
      PrefetchHooks Function({bool menuItemId, bool ingredientId})
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required String orderNumber,
      Value<String> orderType,
      Value<int?> tableNumber,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<double> subtotal,
      Value<double> taxAmount,
      Value<double> totalAmount,
      Value<String?> paymentMethod,
      Value<double?> tenderedAmount,
      Value<String> notes,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<String> orderNumber,
      Value<String> orderType,
      Value<int?> tableNumber,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<double> subtotal,
      Value<double> taxAmount,
      Value<double> totalAmount,
      Value<String?> paymentMethod,
      Value<double?> tenderedAmount,
      Value<String> notes,
    });

final class $$OrdersTableReferences
    extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
  _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItems,
    aliasName: $_aliasNameGenerator(db.orders.id, db.orderItems.orderId),
  );

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DeliveryOrdersTable, List<DeliveryOrder>>
  _deliveryOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deliveryOrders,
    aliasName: $_aliasNameGenerator(db.orders.id, db.deliveryOrders.orderId),
  );

  $$DeliveryOrdersTableProcessedTableManager get deliveryOrdersRefs {
    final manager = $$DeliveryOrdersTableTableManager(
      $_db,
      $_db.deliveryOrders,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_deliveryOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tableNumber => $composableBuilder(
    column: $table.tableNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tenderedAmount => $composableBuilder(
    column: $table.tenderedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> orderItemsRefs(
    Expression<bool> Function($$OrderItemsTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deliveryOrdersRefs(
    Expression<bool> Function($$DeliveryOrdersTableFilterComposer f) f,
  ) {
    final $$DeliveryOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliveryOrders,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliveryOrdersTableFilterComposer(
            $db: $db,
            $table: $db.deliveryOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tableNumber => $composableBuilder(
    column: $table.tableNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tenderedAmount => $composableBuilder(
    column: $table.tenderedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<int> get tableNumber => $composableBuilder(
    column: $table.tableNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tenderedAmount => $composableBuilder(
    column: $table.tenderedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> orderItemsRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> deliveryOrdersRefs<T extends Object>(
    Expression<T> Function($$DeliveryOrdersTableAnnotationComposer a) f,
  ) {
    final $$DeliveryOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliveryOrders,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliveryOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.deliveryOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, $$OrdersTableReferences),
          Order,
          PrefetchHooks Function({bool orderItemsRefs, bool deliveryOrdersRefs})
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String> orderType = const Value.absent(),
                Value<int?> tableNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<double?> tenderedAmount = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                orderNumber: orderNumber,
                orderType: orderType,
                tableNumber: tableNumber,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                subtotal: subtotal,
                taxAmount: taxAmount,
                totalAmount: totalAmount,
                paymentMethod: paymentMethod,
                tenderedAmount: tenderedAmount,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String orderNumber,
                Value<String> orderType = const Value.absent(),
                Value<int?> tableNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<double?> tenderedAmount = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                orderNumber: orderNumber,
                orderType: orderType,
                tableNumber: tableNumber,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                subtotal: subtotal,
                taxAmount: taxAmount,
                totalAmount: totalAmount,
                paymentMethod: paymentMethod,
                tenderedAmount: tenderedAmount,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$OrdersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({orderItemsRefs = false, deliveryOrdersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (orderItemsRefs) db.orderItems,
                    if (deliveryOrdersRefs) db.deliveryOrders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (orderItemsRefs)
                        await $_getPrefetchedData<
                          Order,
                          $OrdersTable,
                          OrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._orderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).orderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (deliveryOrdersRefs)
                        await $_getPrefetchedData<
                          Order,
                          $OrdersTable,
                          DeliveryOrder
                        >(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._deliveryOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).deliveryOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, $$OrdersTableReferences),
      Order,
      PrefetchHooks Function({bool orderItemsRefs, bool deliveryOrdersRefs})
    >;
typedef $$OrderItemsTableCreateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> id,
      required int orderId,
      required int menuItemId,
      required String itemName,
      required int quantity,
      required double unitPrice,
      required double subtotal,
      Value<String> modifiers,
    });
typedef $$OrderItemsTableUpdateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<int> menuItemId,
      Value<String> itemName,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> subtotal,
      Value<String> modifiers,
    });

final class $$OrderItemsTableReferences
    extends BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem> {
  $$OrderItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias(
    $_aliasNameGenerator(db.orderItems.orderId, db.orders.id),
  );

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MenuItemsTable _menuItemIdTable(_$AppDatabase db) =>
      db.menuItems.createAlias(
        $_aliasNameGenerator(db.orderItems.menuItemId, db.menuItems.id),
      );

  $$MenuItemsTableProcessedTableManager get menuItemId {
    final $_column = $_itemColumn<int>('menu_item_id')!;

    final manager = $$MenuItemsTableTableManager(
      $_db,
      $_db.menuItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modifiers => $composableBuilder(
    column: $table.modifiers,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenuItemsTableFilterComposer get menuItemId {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableFilterComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modifiers => $composableBuilder(
    column: $table.modifiers,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenuItemsTableOrderingComposer get menuItemId {
    final $$MenuItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableOrderingComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<String> get modifiers =>
      $composableBuilder(column: $table.modifiers, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MenuItemsTableAnnotationComposer get menuItemId {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuItemId,
      referencedTable: $db.menuItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.menuItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderItemsTable,
          OrderItem,
          $$OrderItemsTableFilterComposer,
          $$OrderItemsTableOrderingComposer,
          $$OrderItemsTableAnnotationComposer,
          $$OrderItemsTableCreateCompanionBuilder,
          $$OrderItemsTableUpdateCompanionBuilder,
          (OrderItem, $$OrderItemsTableReferences),
          OrderItem,
          PrefetchHooks Function({bool orderId, bool menuItemId})
        > {
  $$OrderItemsTableTableManager(_$AppDatabase db, $OrderItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> menuItemId = const Value.absent(),
                Value<String> itemName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<String> modifiers = const Value.absent(),
              }) => OrderItemsCompanion(
                id: id,
                orderId: orderId,
                menuItemId: menuItemId,
                itemName: itemName,
                quantity: quantity,
                unitPrice: unitPrice,
                subtotal: subtotal,
                modifiers: modifiers,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required int menuItemId,
                required String itemName,
                required int quantity,
                required double unitPrice,
                required double subtotal,
                Value<String> modifiers = const Value.absent(),
              }) => OrderItemsCompanion.insert(
                id: id,
                orderId: orderId,
                menuItemId: menuItemId,
                itemName: itemName,
                quantity: quantity,
                unitPrice: unitPrice,
                subtotal: subtotal,
                modifiers: modifiers,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false, menuItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderItemsTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (menuItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.menuItemId,
                                referencedTable: $$OrderItemsTableReferences
                                    ._menuItemIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences
                                    ._menuItemIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderItemsTable,
      OrderItem,
      $$OrderItemsTableFilterComposer,
      $$OrderItemsTableOrderingComposer,
      $$OrderItemsTableAnnotationComposer,
      $$OrderItemsTableCreateCompanionBuilder,
      $$OrderItemsTableUpdateCompanionBuilder,
      (OrderItem, $$OrderItemsTableReferences),
      OrderItem,
      PrefetchHooks Function({bool orderId, bool menuItemId})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      Value<String> description,
      Value<String> category,
      Value<String?> assignedTo,
      Value<String> status,
      Value<String> priority,
      Value<DateTime?> dueDate,
      Value<DateTime?> completedAt,
      Value<String?> completedBy,
      Value<DateTime> createdAt,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> category,
      Value<String?> assignedTo,
      Value<String> status,
      Value<String> priority,
      Value<DateTime?> dueDate,
      Value<DateTime?> completedAt,
      Value<String?> completedBy,
      Value<DateTime> createdAt,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedBy => $composableBuilder(
    column: $table.completedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedBy => $composableBuilder(
    column: $table.completedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedBy => $composableBuilder(
    column: $table.completedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> assignedTo = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> completedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                category: category,
                assignedTo: assignedTo,
                status: status,
                priority: priority,
                dueDate: dueDate,
                completedAt: completedAt,
                completedBy: completedBy,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> assignedTo = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> completedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                category: category,
                assignedTo: assignedTo,
                status: status,
                priority: priority,
                dueDate: dueDate,
                completedAt: completedAt,
                completedBy: completedBy,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
      Value<String?> email,
      Value<int> points,
      Value<String> tier,
      Value<double> totalSpent,
      Value<int> stampsCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastVisitedAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String?> email,
      Value<int> points,
      Value<String> tier,
      Value<double> totalSpent,
      Value<int> stampsCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastVisitedAt,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stampsCount => $composableBuilder(
    column: $table.stampsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastVisitedAt => $composableBuilder(
    column: $table.lastVisitedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stampsCount => $composableBuilder(
    column: $table.stampsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastVisitedAt => $composableBuilder(
    column: $table.lastVisitedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stampsCount => $composableBuilder(
    column: $table.stampsCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastVisitedAt => $composableBuilder(
    column: $table.lastVisitedAt,
    builder: (column) => column,
  );
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<double> totalSpent = const Value.absent(),
                Value<int> stampsCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastVisitedAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                points: points,
                tier: tier,
                totalSpent: totalSpent,
                stampsCount: stampsCount,
                createdAt: createdAt,
                lastVisitedAt: lastVisitedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
                Value<String?> email = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<double> totalSpent = const Value.absent(),
                Value<int> stampsCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastVisitedAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                points: points,
                tier: tier,
                totalSpent: totalSpent,
                stampsCount: stampsCount,
                createdAt: createdAt,
                lastVisitedAt: lastVisitedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$StaffMembersTableCreateCompanionBuilder =
    StaffMembersCompanion Function({
      Value<int> id,
      required String name,
      Value<String> role,
      Value<String> pinCode,
      Value<String?> phone,
      Value<bool> isActive,
      Value<double> hourlyRate,
      Value<DateTime> createdAt,
    });
typedef $$StaffMembersTableUpdateCompanionBuilder =
    StaffMembersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> role,
      Value<String> pinCode,
      Value<String?> phone,
      Value<bool> isActive,
      Value<double> hourlyRate,
      Value<DateTime> createdAt,
    });

final class $$StaffMembersTableReferences
    extends BaseReferences<_$AppDatabase, $StaffMembersTable, StaffMember> {
  $$StaffMembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StaffAttendancesTable, List<StaffAttendance>>
  _staffAttendancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.staffAttendances,
    aliasName: $_aliasNameGenerator(
      db.staffMembers.id,
      db.staffAttendances.staffId,
    ),
  );

  $$StaffAttendancesTableProcessedTableManager get staffAttendancesRefs {
    final manager = $$StaffAttendancesTableTableManager(
      $_db,
      $_db.staffAttendances,
    ).filter((f) => f.staffId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _staffAttendancesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StaffMembersTableFilterComposer
    extends Composer<_$AppDatabase, $StaffMembersTable> {
  $$StaffMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinCode => $composableBuilder(
    column: $table.pinCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> staffAttendancesRefs(
    Expression<bool> Function($$StaffAttendancesTableFilterComposer f) f,
  ) {
    final $$StaffAttendancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.staffAttendances,
      getReferencedColumn: (t) => t.staffId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StaffAttendancesTableFilterComposer(
            $db: $db,
            $table: $db.staffAttendances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StaffMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffMembersTable> {
  $$StaffMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinCode => $composableBuilder(
    column: $table.pinCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffMembersTable> {
  $$StaffMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pinCode =>
      $composableBuilder(column: $table.pinCode, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> staffAttendancesRefs<T extends Object>(
    Expression<T> Function($$StaffAttendancesTableAnnotationComposer a) f,
  ) {
    final $$StaffAttendancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.staffAttendances,
      getReferencedColumn: (t) => t.staffId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StaffAttendancesTableAnnotationComposer(
            $db: $db,
            $table: $db.staffAttendances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StaffMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffMembersTable,
          StaffMember,
          $$StaffMembersTableFilterComposer,
          $$StaffMembersTableOrderingComposer,
          $$StaffMembersTableAnnotationComposer,
          $$StaffMembersTableCreateCompanionBuilder,
          $$StaffMembersTableUpdateCompanionBuilder,
          (StaffMember, $$StaffMembersTableReferences),
          StaffMember,
          PrefetchHooks Function({bool staffAttendancesRefs})
        > {
  $$StaffMembersTableTableManager(_$AppDatabase db, $StaffMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> pinCode = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<double> hourlyRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StaffMembersCompanion(
                id: id,
                name: name,
                role: role,
                pinCode: pinCode,
                phone: phone,
                isActive: isActive,
                hourlyRate: hourlyRate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> role = const Value.absent(),
                Value<String> pinCode = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<double> hourlyRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StaffMembersCompanion.insert(
                id: id,
                name: name,
                role: role,
                pinCode: pinCode,
                phone: phone,
                isActive: isActive,
                hourlyRate: hourlyRate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StaffMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({staffAttendancesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (staffAttendancesRefs) db.staffAttendances,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (staffAttendancesRefs)
                    await $_getPrefetchedData<
                      StaffMember,
                      $StaffMembersTable,
                      StaffAttendance
                    >(
                      currentTable: table,
                      referencedTable: $$StaffMembersTableReferences
                          ._staffAttendancesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StaffMembersTableReferences(
                            db,
                            table,
                            p0,
                          ).staffAttendancesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.staffId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StaffMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffMembersTable,
      StaffMember,
      $$StaffMembersTableFilterComposer,
      $$StaffMembersTableOrderingComposer,
      $$StaffMembersTableAnnotationComposer,
      $$StaffMembersTableCreateCompanionBuilder,
      $$StaffMembersTableUpdateCompanionBuilder,
      (StaffMember, $$StaffMembersTableReferences),
      StaffMember,
      PrefetchHooks Function({bool staffAttendancesRefs})
    >;
typedef $$StaffAttendancesTableCreateCompanionBuilder =
    StaffAttendancesCompanion Function({
      Value<int> id,
      required int staffId,
      required String staffName,
      Value<DateTime> clockInTime,
      Value<DateTime?> clockOutTime,
      Value<int> totalMinutes,
      Value<String> notes,
      required String date,
    });
typedef $$StaffAttendancesTableUpdateCompanionBuilder =
    StaffAttendancesCompanion Function({
      Value<int> id,
      Value<int> staffId,
      Value<String> staffName,
      Value<DateTime> clockInTime,
      Value<DateTime?> clockOutTime,
      Value<int> totalMinutes,
      Value<String> notes,
      Value<String> date,
    });

final class $$StaffAttendancesTableReferences
    extends
        BaseReferences<_$AppDatabase, $StaffAttendancesTable, StaffAttendance> {
  $$StaffAttendancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StaffMembersTable _staffIdTable(_$AppDatabase db) =>
      db.staffMembers.createAlias(
        $_aliasNameGenerator(db.staffAttendances.staffId, db.staffMembers.id),
      );

  $$StaffMembersTableProcessedTableManager get staffId {
    final $_column = $_itemColumn<int>('staff_id')!;

    final manager = $$StaffMembersTableTableManager(
      $_db,
      $_db.staffMembers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_staffIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StaffAttendancesTableFilterComposer
    extends Composer<_$AppDatabase, $StaffAttendancesTable> {
  $$StaffAttendancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffName => $composableBuilder(
    column: $table.staffName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clockInTime => $composableBuilder(
    column: $table.clockInTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clockOutTime => $composableBuilder(
    column: $table.clockOutTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMinutes => $composableBuilder(
    column: $table.totalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$StaffMembersTableFilterComposer get staffId {
    final $$StaffMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.staffId,
      referencedTable: $db.staffMembers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StaffMembersTableFilterComposer(
            $db: $db,
            $table: $db.staffMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StaffAttendancesTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffAttendancesTable> {
  $$StaffAttendancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffName => $composableBuilder(
    column: $table.staffName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clockInTime => $composableBuilder(
    column: $table.clockInTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clockOutTime => $composableBuilder(
    column: $table.clockOutTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMinutes => $composableBuilder(
    column: $table.totalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$StaffMembersTableOrderingComposer get staffId {
    final $$StaffMembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.staffId,
      referencedTable: $db.staffMembers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StaffMembersTableOrderingComposer(
            $db: $db,
            $table: $db.staffMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StaffAttendancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffAttendancesTable> {
  $$StaffAttendancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get staffName =>
      $composableBuilder(column: $table.staffName, builder: (column) => column);

  GeneratedColumn<DateTime> get clockInTime => $composableBuilder(
    column: $table.clockInTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clockOutTime => $composableBuilder(
    column: $table.clockOutTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalMinutes => $composableBuilder(
    column: $table.totalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$StaffMembersTableAnnotationComposer get staffId {
    final $$StaffMembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.staffId,
      referencedTable: $db.staffMembers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StaffMembersTableAnnotationComposer(
            $db: $db,
            $table: $db.staffMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StaffAttendancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffAttendancesTable,
          StaffAttendance,
          $$StaffAttendancesTableFilterComposer,
          $$StaffAttendancesTableOrderingComposer,
          $$StaffAttendancesTableAnnotationComposer,
          $$StaffAttendancesTableCreateCompanionBuilder,
          $$StaffAttendancesTableUpdateCompanionBuilder,
          (StaffAttendance, $$StaffAttendancesTableReferences),
          StaffAttendance,
          PrefetchHooks Function({bool staffId})
        > {
  $$StaffAttendancesTableTableManager(
    _$AppDatabase db,
    $StaffAttendancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffAttendancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffAttendancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffAttendancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> staffId = const Value.absent(),
                Value<String> staffName = const Value.absent(),
                Value<DateTime> clockInTime = const Value.absent(),
                Value<DateTime?> clockOutTime = const Value.absent(),
                Value<int> totalMinutes = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => StaffAttendancesCompanion(
                id: id,
                staffId: staffId,
                staffName: staffName,
                clockInTime: clockInTime,
                clockOutTime: clockOutTime,
                totalMinutes: totalMinutes,
                notes: notes,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int staffId,
                required String staffName,
                Value<DateTime> clockInTime = const Value.absent(),
                Value<DateTime?> clockOutTime = const Value.absent(),
                Value<int> totalMinutes = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required String date,
              }) => StaffAttendancesCompanion.insert(
                id: id,
                staffId: staffId,
                staffName: staffName,
                clockInTime: clockInTime,
                clockOutTime: clockOutTime,
                totalMinutes: totalMinutes,
                notes: notes,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StaffAttendancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({staffId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (staffId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.staffId,
                                referencedTable:
                                    $$StaffAttendancesTableReferences
                                        ._staffIdTable(db),
                                referencedColumn:
                                    $$StaffAttendancesTableReferences
                                        ._staffIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StaffAttendancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffAttendancesTable,
      StaffAttendance,
      $$StaffAttendancesTableFilterComposer,
      $$StaffAttendancesTableOrderingComposer,
      $$StaffAttendancesTableAnnotationComposer,
      $$StaffAttendancesTableCreateCompanionBuilder,
      $$StaffAttendancesTableUpdateCompanionBuilder,
      (StaffAttendance, $$StaffAttendancesTableReferences),
      StaffAttendance,
      PrefetchHooks Function({bool staffId})
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> contactPerson,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String> paymentTerms,
      Value<String> category,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> contactPerson,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String> paymentTerms,
      Value<String> category,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchaseOrdersTable, List<PurchaseOrder>>
  _purchaseOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseOrders,
    aliasName: $_aliasNameGenerator(
      db.suppliers.id,
      db.purchaseOrders.supplierId,
    ),
  );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrdersRefs {
    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseOrdersRefs(
    Expression<bool> Function($$PurchaseOrdersTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> purchaseOrdersRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, $$SuppliersTableReferences),
          Supplier,
          PrefetchHooks Function({bool purchaseOrdersRefs})
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> paymentTerms = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                contactPerson: contactPerson,
                phone: phone,
                email: email,
                address: address,
                paymentTerms: paymentTerms,
                category: category,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String> paymentTerms = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                contactPerson: contactPerson,
                phone: phone,
                email: email,
                address: address,
                paymentTerms: paymentTerms,
                category: category,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseOrdersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (purchaseOrdersRefs) db.purchaseOrders,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseOrdersRefs)
                    await $_getPrefetchedData<
                      Supplier,
                      $SuppliersTable,
                      PurchaseOrder
                    >(
                      currentTable: table,
                      referencedTable: $$SuppliersTableReferences
                          ._purchaseOrdersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SuppliersTableReferences(
                            db,
                            table,
                            p0,
                          ).purchaseOrdersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.supplierId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, $$SuppliersTableReferences),
      Supplier,
      PrefetchHooks Function({bool purchaseOrdersRefs})
    >;
typedef $$PurchaseOrdersTableCreateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      required String poNumber,
      required int supplierId,
      required String supplierName,
      Value<String> status,
      Value<double> totalAmount,
      Value<DateTime> orderDate,
      Value<DateTime?> expectedDate,
      Value<DateTime?> receivedDate,
      Value<String> notes,
    });
typedef $$PurchaseOrdersTableUpdateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      Value<String> poNumber,
      Value<int> supplierId,
      Value<String> supplierName,
      Value<String> status,
      Value<double> totalAmount,
      Value<DateTime> orderDate,
      Value<DateTime?> expectedDate,
      Value<DateTime?> receivedDate,
      Value<String> notes,
    });

final class $$PurchaseOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder> {
  $$PurchaseOrdersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias(
        $_aliasNameGenerator(db.purchaseOrders.supplierId, db.suppliers.id),
      );

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseOrderItemsTable, List<PurchaseOrderItem>>
  _purchaseOrderItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrderItems,
        aliasName: $_aliasNameGenerator(
          db.purchaseOrders.id,
          db.purchaseOrderItems.poId,
        ),
      );

  $$PurchaseOrderItemsTableProcessedTableManager get purchaseOrderItemsRefs {
    final manager = $$PurchaseOrderItemsTableTableManager(
      $_db,
      $_db.purchaseOrderItems,
    ).filter((f) => f.poId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poNumber => $composableBuilder(
    column: $table.poNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderDate => $composableBuilder(
    column: $table.orderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseOrderItemsRefs(
    Expression<bool> Function($$PurchaseOrderItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrderItems,
      getReferencedColumn: (t) => t.poId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poNumber => $composableBuilder(
    column: $table.poNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderDate => $composableBuilder(
    column: $table.orderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get poNumber =>
      $composableBuilder(column: $table.poNumber, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseOrderItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrderItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseOrderItems,
          getReferencedColumn: (t) => t.poId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrderItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrderItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTable,
          PurchaseOrder,
          $$PurchaseOrdersTableFilterComposer,
          $$PurchaseOrdersTableOrderingComposer,
          $$PurchaseOrdersTableAnnotationComposer,
          $$PurchaseOrdersTableCreateCompanionBuilder,
          $$PurchaseOrdersTableUpdateCompanionBuilder,
          (PurchaseOrder, $$PurchaseOrdersTableReferences),
          PurchaseOrder,
          PrefetchHooks Function({bool supplierId, bool purchaseOrderItemsRefs})
        > {
  $$PurchaseOrdersTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> poNumber = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> orderDate = const Value.absent(),
                Value<DateTime?> expectedDate = const Value.absent(),
                Value<DateTime?> receivedDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => PurchaseOrdersCompanion(
                id: id,
                poNumber: poNumber,
                supplierId: supplierId,
                supplierName: supplierName,
                status: status,
                totalAmount: totalAmount,
                orderDate: orderDate,
                expectedDate: expectedDate,
                receivedDate: receivedDate,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String poNumber,
                required int supplierId,
                required String supplierName,
                Value<String> status = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> orderDate = const Value.absent(),
                Value<DateTime?> expectedDate = const Value.absent(),
                Value<DateTime?> receivedDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => PurchaseOrdersCompanion.insert(
                id: id,
                poNumber: poNumber,
                supplierId: supplierId,
                supplierName: supplierName,
                status: status,
                totalAmount: totalAmount,
                orderDate: orderDate,
                expectedDate: expectedDate,
                receivedDate: receivedDate,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({supplierId = false, purchaseOrderItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseOrderItemsRefs) db.purchaseOrderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$PurchaseOrdersTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseOrderItemsRefs)
                        await $_getPrefetchedData<
                          PurchaseOrder,
                          $PurchaseOrdersTable,
                          PurchaseOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseOrdersTableReferences
                              ._purchaseOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseOrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.poId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTable,
      PurchaseOrder,
      $$PurchaseOrdersTableFilterComposer,
      $$PurchaseOrdersTableOrderingComposer,
      $$PurchaseOrdersTableAnnotationComposer,
      $$PurchaseOrdersTableCreateCompanionBuilder,
      $$PurchaseOrdersTableUpdateCompanionBuilder,
      (PurchaseOrder, $$PurchaseOrdersTableReferences),
      PurchaseOrder,
      PrefetchHooks Function({bool supplierId, bool purchaseOrderItemsRefs})
    >;
typedef $$PurchaseOrderItemsTableCreateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<int> id,
      required int poId,
      required int ingredientId,
      required String ingredientName,
      Value<String> unit,
      Value<double> quantityOrdered,
      Value<double> quantityReceived,
      Value<double> unitCost,
      Value<double> subtotal,
    });
typedef $$PurchaseOrderItemsTableUpdateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<int> id,
      Value<int> poId,
      Value<int> ingredientId,
      Value<String> ingredientName,
      Value<String> unit,
      Value<double> quantityOrdered,
      Value<double> quantityReceived,
      Value<double> unitCost,
      Value<double> subtotal,
    });

final class $$PurchaseOrderItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem
        > {
  $$PurchaseOrderItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseOrdersTable _poIdTable(_$AppDatabase db) =>
      db.purchaseOrders.createAlias(
        $_aliasNameGenerator(db.purchaseOrderItems.poId, db.purchaseOrders.id),
      );

  $$PurchaseOrdersTableProcessedTableManager get poId {
    final $_column = $_itemColumn<int>('po_id')!;

    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_poIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(
          db.purchaseOrderItems.ingredientId,
          db.ingredients.id,
        ),
      );

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityOrdered => $composableBuilder(
    column: $table.quantityOrdered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityReceived => $composableBuilder(
    column: $table.quantityReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseOrdersTableFilterComposer get poId {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityOrdered => $composableBuilder(
    column: $table.quantityOrdered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityReceived => $composableBuilder(
    column: $table.quantityReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseOrdersTableOrderingComposer get poId {
    final $$PurchaseOrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get quantityOrdered => $composableBuilder(
    column: $table.quantityOrdered,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantityReceived => $composableBuilder(
    column: $table.quantityReceived,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  $$PurchaseOrdersTableAnnotationComposer get poId {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem,
          $$PurchaseOrderItemsTableFilterComposer,
          $$PurchaseOrderItemsTableOrderingComposer,
          $$PurchaseOrderItemsTableAnnotationComposer,
          $$PurchaseOrderItemsTableCreateCompanionBuilder,
          $$PurchaseOrderItemsTableUpdateCompanionBuilder,
          (PurchaseOrderItem, $$PurchaseOrderItemsTableReferences),
          PurchaseOrderItem,
          PrefetchHooks Function({bool poId, bool ingredientId})
        > {
  $$PurchaseOrderItemsTableTableManager(
    _$AppDatabase db,
    $PurchaseOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrderItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> poId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> ingredientName = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> quantityOrdered = const Value.absent(),
                Value<double> quantityReceived = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
              }) => PurchaseOrderItemsCompanion(
                id: id,
                poId: poId,
                ingredientId: ingredientId,
                ingredientName: ingredientName,
                unit: unit,
                quantityOrdered: quantityOrdered,
                quantityReceived: quantityReceived,
                unitCost: unitCost,
                subtotal: subtotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int poId,
                required int ingredientId,
                required String ingredientName,
                Value<String> unit = const Value.absent(),
                Value<double> quantityOrdered = const Value.absent(),
                Value<double> quantityReceived = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
              }) => PurchaseOrderItemsCompanion.insert(
                id: id,
                poId: poId,
                ingredientId: ingredientId,
                ingredientName: ingredientName,
                unit: unit,
                quantityOrdered: quantityOrdered,
                quantityReceived: quantityReceived,
                unitCost: unitCost,
                subtotal: subtotal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseOrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({poId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (poId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.poId,
                                referencedTable:
                                    $$PurchaseOrderItemsTableReferences
                                        ._poIdTable(db),
                                referencedColumn:
                                    $$PurchaseOrderItemsTableReferences
                                        ._poIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$PurchaseOrderItemsTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$PurchaseOrderItemsTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrderItemsTable,
      PurchaseOrderItem,
      $$PurchaseOrderItemsTableFilterComposer,
      $$PurchaseOrderItemsTableOrderingComposer,
      $$PurchaseOrderItemsTableAnnotationComposer,
      $$PurchaseOrderItemsTableCreateCompanionBuilder,
      $$PurchaseOrderItemsTableUpdateCompanionBuilder,
      (PurchaseOrderItem, $$PurchaseOrderItemsTableReferences),
      PurchaseOrderItem,
      PrefetchHooks Function({bool poId, bool ingredientId})
    >;
typedef $$StockAuditsTableCreateCompanionBuilder =
    StockAuditsCompanion Function({
      Value<int> id,
      required int ingredientId,
      required String ingredientName,
      Value<String> unit,
      Value<double> expectedStock,
      Value<double> actualStock,
      Value<double> varianceQuantity,
      Value<double> varianceValue,
      Value<String> reason,
      Value<String> auditedBy,
      Value<DateTime> auditedAt,
      Value<String> notes,
    });
typedef $$StockAuditsTableUpdateCompanionBuilder =
    StockAuditsCompanion Function({
      Value<int> id,
      Value<int> ingredientId,
      Value<String> ingredientName,
      Value<String> unit,
      Value<double> expectedStock,
      Value<double> actualStock,
      Value<double> varianceQuantity,
      Value<double> varianceValue,
      Value<String> reason,
      Value<String> auditedBy,
      Value<DateTime> auditedAt,
      Value<String> notes,
    });

final class $$StockAuditsTableReferences
    extends BaseReferences<_$AppDatabase, $StockAuditsTable, StockAudit> {
  $$StockAuditsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(db.stockAudits.ingredientId, db.ingredients.id),
      );

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockAuditsTableFilterComposer
    extends Composer<_$AppDatabase, $StockAuditsTable> {
  $$StockAuditsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedStock => $composableBuilder(
    column: $table.expectedStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualStock => $composableBuilder(
    column: $table.actualStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get varianceQuantity => $composableBuilder(
    column: $table.varianceQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get varianceValue => $composableBuilder(
    column: $table.varianceValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get auditedBy => $composableBuilder(
    column: $table.auditedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get auditedAt => $composableBuilder(
    column: $table.auditedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAuditsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockAuditsTable> {
  $$StockAuditsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedStock => $composableBuilder(
    column: $table.expectedStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualStock => $composableBuilder(
    column: $table.actualStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get varianceQuantity => $composableBuilder(
    column: $table.varianceQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get varianceValue => $composableBuilder(
    column: $table.varianceValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get auditedBy => $composableBuilder(
    column: $table.auditedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get auditedAt => $composableBuilder(
    column: $table.auditedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAuditsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockAuditsTable> {
  $$StockAuditsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ingredientName => $composableBuilder(
    column: $table.ingredientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get expectedStock => $composableBuilder(
    column: $table.expectedStock,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualStock => $composableBuilder(
    column: $table.actualStock,
    builder: (column) => column,
  );

  GeneratedColumn<double> get varianceQuantity => $composableBuilder(
    column: $table.varianceQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get varianceValue => $composableBuilder(
    column: $table.varianceValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get auditedBy =>
      $composableBuilder(column: $table.auditedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get auditedAt =>
      $composableBuilder(column: $table.auditedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAuditsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockAuditsTable,
          StockAudit,
          $$StockAuditsTableFilterComposer,
          $$StockAuditsTableOrderingComposer,
          $$StockAuditsTableAnnotationComposer,
          $$StockAuditsTableCreateCompanionBuilder,
          $$StockAuditsTableUpdateCompanionBuilder,
          (StockAudit, $$StockAuditsTableReferences),
          StockAudit,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$StockAuditsTableTableManager(_$AppDatabase db, $StockAuditsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockAuditsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockAuditsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockAuditsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> ingredientName = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> expectedStock = const Value.absent(),
                Value<double> actualStock = const Value.absent(),
                Value<double> varianceQuantity = const Value.absent(),
                Value<double> varianceValue = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> auditedBy = const Value.absent(),
                Value<DateTime> auditedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => StockAuditsCompanion(
                id: id,
                ingredientId: ingredientId,
                ingredientName: ingredientName,
                unit: unit,
                expectedStock: expectedStock,
                actualStock: actualStock,
                varianceQuantity: varianceQuantity,
                varianceValue: varianceValue,
                reason: reason,
                auditedBy: auditedBy,
                auditedAt: auditedAt,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ingredientId,
                required String ingredientName,
                Value<String> unit = const Value.absent(),
                Value<double> expectedStock = const Value.absent(),
                Value<double> actualStock = const Value.absent(),
                Value<double> varianceQuantity = const Value.absent(),
                Value<double> varianceValue = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> auditedBy = const Value.absent(),
                Value<DateTime> auditedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => StockAuditsCompanion.insert(
                id: id,
                ingredientId: ingredientId,
                ingredientName: ingredientName,
                unit: unit,
                expectedStock: expectedStock,
                actualStock: actualStock,
                varianceQuantity: varianceQuantity,
                varianceValue: varianceValue,
                reason: reason,
                auditedBy: auditedBy,
                auditedAt: auditedAt,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockAuditsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable: $$StockAuditsTableReferences
                                    ._ingredientIdTable(db),
                                referencedColumn: $$StockAuditsTableReferences
                                    ._ingredientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockAuditsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockAuditsTable,
      StockAudit,
      $$StockAuditsTableFilterComposer,
      $$StockAuditsTableOrderingComposer,
      $$StockAuditsTableAnnotationComposer,
      $$StockAuditsTableCreateCompanionBuilder,
      $$StockAuditsTableUpdateCompanionBuilder,
      (StockAudit, $$StockAuditsTableReferences),
      StockAudit,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<String> recipient,
      Value<String> description,
      Value<String?> receiptNumber,
      Value<String> recordedBy,
      Value<DateTime> expenseDate,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<String> recipient,
      Value<String> description,
      Value<String?> receiptNumber,
      Value<String> recordedBy,
      Value<DateTime> expenseDate,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipient =>
      $composableBuilder(column: $table.recipient, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> recipient = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> receiptNumber = const Value.absent(),
                Value<String> recordedBy = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                category: category,
                amount: amount,
                paymentMethod: paymentMethod,
                recipient: recipient,
                description: description,
                receiptNumber: receiptNumber,
                recordedBy: recordedBy,
                expenseDate: expenseDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> recipient = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> receiptNumber = const Value.absent(),
                Value<String> recordedBy = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                category: category,
                amount: amount,
                paymentMethod: paymentMethod,
                recipient: recipient,
                description: description,
                receiptNumber: receiptNumber,
                recordedBy: recordedBy,
                expenseDate: expenseDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$CashDrawerLogsTableCreateCompanionBuilder =
    CashDrawerLogsCompanion Function({
      Value<int> id,
      required String type,
      Value<double> amount,
      Value<String> reason,
      Value<String> recordedBy,
      Value<DateTime> createdAt,
    });
typedef $$CashDrawerLogsTableUpdateCompanionBuilder =
    CashDrawerLogsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<double> amount,
      Value<String> reason,
      Value<String> recordedBy,
      Value<DateTime> createdAt,
    });

class $$CashDrawerLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CashDrawerLogsTable> {
  $$CashDrawerLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashDrawerLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashDrawerLogsTable> {
  $$CashDrawerLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashDrawerLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashDrawerLogsTable> {
  $$CashDrawerLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CashDrawerLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashDrawerLogsTable,
          CashDrawerLog,
          $$CashDrawerLogsTableFilterComposer,
          $$CashDrawerLogsTableOrderingComposer,
          $$CashDrawerLogsTableAnnotationComposer,
          $$CashDrawerLogsTableCreateCompanionBuilder,
          $$CashDrawerLogsTableUpdateCompanionBuilder,
          (
            CashDrawerLog,
            BaseReferences<_$AppDatabase, $CashDrawerLogsTable, CashDrawerLog>,
          ),
          CashDrawerLog,
          PrefetchHooks Function()
        > {
  $$CashDrawerLogsTableTableManager(
    _$AppDatabase db,
    $CashDrawerLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashDrawerLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashDrawerLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashDrawerLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> recordedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CashDrawerLogsCompanion(
                id: id,
                type: type,
                amount: amount,
                reason: reason,
                recordedBy: recordedBy,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                Value<double> amount = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> recordedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CashDrawerLogsCompanion.insert(
                id: id,
                type: type,
                amount: amount,
                reason: reason,
                recordedBy: recordedBy,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashDrawerLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashDrawerLogsTable,
      CashDrawerLog,
      $$CashDrawerLogsTableFilterComposer,
      $$CashDrawerLogsTableOrderingComposer,
      $$CashDrawerLogsTableAnnotationComposer,
      $$CashDrawerLogsTableCreateCompanionBuilder,
      $$CashDrawerLogsTableUpdateCompanionBuilder,
      (
        CashDrawerLog,
        BaseReferences<_$AppDatabase, $CashDrawerLogsTable, CashDrawerLog>,
      ),
      CashDrawerLog,
      PrefetchHooks Function()
    >;
typedef $$SyncTombstonesTableCreateCompanionBuilder =
    SyncTombstonesCompanion Function({
      Value<int> id,
      required String targetTable,
      required String recordKey,
      Value<DateTime> deletedAt,
      Value<bool> isSynced,
    });
typedef $$SyncTombstonesTableUpdateCompanionBuilder =
    SyncTombstonesCompanion Function({
      Value<int> id,
      Value<String> targetTable,
      Value<String> recordKey,
      Value<DateTime> deletedAt,
      Value<bool> isSynced,
    });

class $$SyncTombstonesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordKey => $composableBuilder(
    column: $table.recordKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncTombstonesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordKey => $composableBuilder(
    column: $table.recordKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncTombstonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncTombstonesTable> {
  $$SyncTombstonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordKey =>
      $composableBuilder(column: $table.recordKey, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$SyncTombstonesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncTombstonesTable,
          SyncTombstone,
          $$SyncTombstonesTableFilterComposer,
          $$SyncTombstonesTableOrderingComposer,
          $$SyncTombstonesTableAnnotationComposer,
          $$SyncTombstonesTableCreateCompanionBuilder,
          $$SyncTombstonesTableUpdateCompanionBuilder,
          (
            SyncTombstone,
            BaseReferences<_$AppDatabase, $SyncTombstonesTable, SyncTombstone>,
          ),
          SyncTombstone,
          PrefetchHooks Function()
        > {
  $$SyncTombstonesTableTableManager(
    _$AppDatabase db,
    $SyncTombstonesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncTombstonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncTombstonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncTombstonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> recordKey = const Value.absent(),
                Value<DateTime> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => SyncTombstonesCompanion(
                id: id,
                targetTable: targetTable,
                recordKey: recordKey,
                deletedAt: deletedAt,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String targetTable,
                required String recordKey,
                Value<DateTime> deletedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => SyncTombstonesCompanion.insert(
                id: id,
                targetTable: targetTable,
                recordKey: recordKey,
                deletedAt: deletedAt,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncTombstonesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncTombstonesTable,
      SyncTombstone,
      $$SyncTombstonesTableFilterComposer,
      $$SyncTombstonesTableOrderingComposer,
      $$SyncTombstonesTableAnnotationComposer,
      $$SyncTombstonesTableCreateCompanionBuilder,
      $$SyncTombstonesTableUpdateCompanionBuilder,
      (
        SyncTombstone,
        BaseReferences<_$AppDatabase, $SyncTombstonesTable, SyncTombstone>,
      ),
      SyncTombstone,
      PrefetchHooks Function()
    >;
typedef $$OutletsTableCreateCompanionBuilder =
    OutletsCompanion Function({
      Value<int> id,
      required String name,
      required String code,
      Value<String> address,
      Value<String> phone,
      Value<bool> isPrimary,
      Value<double> priceMultiplier,
      Value<DateTime> createdAt,
    });
typedef $$OutletsTableUpdateCompanionBuilder =
    OutletsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> code,
      Value<String> address,
      Value<String> phone,
      Value<bool> isPrimary,
      Value<double> priceMultiplier,
      Value<DateTime> createdAt,
    });

class $$OutletsTableFilterComposer
    extends Composer<_$AppDatabase, $OutletsTable> {
  $$OutletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceMultiplier => $composableBuilder(
    column: $table.priceMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutletsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutletsTable> {
  $$OutletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceMultiplier => $composableBuilder(
    column: $table.priceMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutletsTable> {
  $$OutletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<double> get priceMultiplier => $composableBuilder(
    column: $table.priceMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OutletsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutletsTable,
          Outlet,
          $$OutletsTableFilterComposer,
          $$OutletsTableOrderingComposer,
          $$OutletsTableAnnotationComposer,
          $$OutletsTableCreateCompanionBuilder,
          $$OutletsTableUpdateCompanionBuilder,
          (Outlet, BaseReferences<_$AppDatabase, $OutletsTable, Outlet>),
          Outlet,
          PrefetchHooks Function()
        > {
  $$OutletsTableTableManager(_$AppDatabase db, $OutletsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<double> priceMultiplier = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OutletsCompanion(
                id: id,
                name: name,
                code: code,
                address: address,
                phone: phone,
                isPrimary: isPrimary,
                priceMultiplier: priceMultiplier,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String code,
                Value<String> address = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<double> priceMultiplier = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OutletsCompanion.insert(
                id: id,
                name: name,
                code: code,
                address: address,
                phone: phone,
                isPrimary: isPrimary,
                priceMultiplier: priceMultiplier,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutletsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutletsTable,
      Outlet,
      $$OutletsTableFilterComposer,
      $$OutletsTableOrderingComposer,
      $$OutletsTableAnnotationComposer,
      $$OutletsTableCreateCompanionBuilder,
      $$OutletsTableUpdateCompanionBuilder,
      (Outlet, BaseReferences<_$AppDatabase, $OutletsTable, Outlet>),
      Outlet,
      PrefetchHooks Function()
    >;
typedef $$StockTransfersTableCreateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<int> id,
      required String transferNumber,
      required int sourceOutletId,
      required int targetOutletId,
      required int ingredientId,
      required double quantity,
      Value<String> status,
      Value<String> requestedBy,
      Value<DateTime> transferDate,
      Value<String> notes,
    });
typedef $$StockTransfersTableUpdateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<int> id,
      Value<String> transferNumber,
      Value<int> sourceOutletId,
      Value<int> targetOutletId,
      Value<int> ingredientId,
      Value<double> quantity,
      Value<String> status,
      Value<String> requestedBy,
      Value<DateTime> transferDate,
      Value<String> notes,
    });

class $$StockTransfersTableFilterComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferNumber => $composableBuilder(
    column: $table.transferNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceOutletId => $composableBuilder(
    column: $table.sourceOutletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetOutletId => $composableBuilder(
    column: $table.targetOutletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transferDate => $composableBuilder(
    column: $table.transferDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockTransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferNumber => $composableBuilder(
    column: $table.transferNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceOutletId => $composableBuilder(
    column: $table.sourceOutletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetOutletId => $composableBuilder(
    column: $table.targetOutletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transferDate => $composableBuilder(
    column: $table.transferDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockTransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transferNumber => $composableBuilder(
    column: $table.transferNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourceOutletId => $composableBuilder(
    column: $table.sourceOutletId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetOutletId => $composableBuilder(
    column: $table.targetOutletId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transferDate => $composableBuilder(
    column: $table.transferDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$StockTransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockTransfersTable,
          StockTransfer,
          $$StockTransfersTableFilterComposer,
          $$StockTransfersTableOrderingComposer,
          $$StockTransfersTableAnnotationComposer,
          $$StockTransfersTableCreateCompanionBuilder,
          $$StockTransfersTableUpdateCompanionBuilder,
          (
            StockTransfer,
            BaseReferences<_$AppDatabase, $StockTransfersTable, StockTransfer>,
          ),
          StockTransfer,
          PrefetchHooks Function()
        > {
  $$StockTransfersTableTableManager(
    _$AppDatabase db,
    $StockTransfersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> transferNumber = const Value.absent(),
                Value<int> sourceOutletId = const Value.absent(),
                Value<int> targetOutletId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> requestedBy = const Value.absent(),
                Value<DateTime> transferDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => StockTransfersCompanion(
                id: id,
                transferNumber: transferNumber,
                sourceOutletId: sourceOutletId,
                targetOutletId: targetOutletId,
                ingredientId: ingredientId,
                quantity: quantity,
                status: status,
                requestedBy: requestedBy,
                transferDate: transferDate,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String transferNumber,
                required int sourceOutletId,
                required int targetOutletId,
                required int ingredientId,
                required double quantity,
                Value<String> status = const Value.absent(),
                Value<String> requestedBy = const Value.absent(),
                Value<DateTime> transferDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => StockTransfersCompanion.insert(
                id: id,
                transferNumber: transferNumber,
                sourceOutletId: sourceOutletId,
                targetOutletId: targetOutletId,
                ingredientId: ingredientId,
                quantity: quantity,
                status: status,
                requestedBy: requestedBy,
                transferDate: transferDate,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockTransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockTransfersTable,
      StockTransfer,
      $$StockTransfersTableFilterComposer,
      $$StockTransfersTableOrderingComposer,
      $$StockTransfersTableAnnotationComposer,
      $$StockTransfersTableCreateCompanionBuilder,
      $$StockTransfersTableUpdateCompanionBuilder,
      (
        StockTransfer,
        BaseReferences<_$AppDatabase, $StockTransfersTable, StockTransfer>,
      ),
      StockTransfer,
      PrefetchHooks Function()
    >;
typedef $$DeliveryOrdersTableCreateCompanionBuilder =
    DeliveryOrdersCompanion Function({
      Value<int> id,
      required int orderId,
      required String channel,
      required String platformOrderId,
      Value<double> commissionRate,
      Value<double> commissionAmount,
      Value<double> netPayout,
      Value<String?> riderName,
      Value<String?> riderPhone,
      Value<String> pickupStatus,
      Value<DateTime?> estimatedPickupTime,
    });
typedef $$DeliveryOrdersTableUpdateCompanionBuilder =
    DeliveryOrdersCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<String> channel,
      Value<String> platformOrderId,
      Value<double> commissionRate,
      Value<double> commissionAmount,
      Value<double> netPayout,
      Value<String?> riderName,
      Value<String?> riderPhone,
      Value<String> pickupStatus,
      Value<DateTime?> estimatedPickupTime,
    });

final class $$DeliveryOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $DeliveryOrdersTable, DeliveryOrder> {
  $$DeliveryOrdersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias(
    $_aliasNameGenerator(db.deliveryOrders.orderId, db.orders.id),
  );

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeliveryOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $DeliveryOrdersTable> {
  $$DeliveryOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformOrderId => $composableBuilder(
    column: $table.platformOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionAmount => $composableBuilder(
    column: $table.commissionAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netPayout => $composableBuilder(
    column: $table.netPayout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riderName => $composableBuilder(
    column: $table.riderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riderPhone => $composableBuilder(
    column: $table.riderPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pickupStatus => $composableBuilder(
    column: $table.pickupStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get estimatedPickupTime => $composableBuilder(
    column: $table.estimatedPickupTime,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliveryOrdersTable> {
  $$DeliveryOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformOrderId => $composableBuilder(
    column: $table.platformOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionAmount => $composableBuilder(
    column: $table.commissionAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netPayout => $composableBuilder(
    column: $table.netPayout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riderName => $composableBuilder(
    column: $table.riderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riderPhone => $composableBuilder(
    column: $table.riderPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pickupStatus => $composableBuilder(
    column: $table.pickupStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get estimatedPickupTime => $composableBuilder(
    column: $table.estimatedPickupTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliveryOrdersTable> {
  $$DeliveryOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<String> get platformOrderId => $composableBuilder(
    column: $table.platformOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionAmount => $composableBuilder(
    column: $table.commissionAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netPayout =>
      $composableBuilder(column: $table.netPayout, builder: (column) => column);

  GeneratedColumn<String> get riderName =>
      $composableBuilder(column: $table.riderName, builder: (column) => column);

  GeneratedColumn<String> get riderPhone => $composableBuilder(
    column: $table.riderPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pickupStatus => $composableBuilder(
    column: $table.pickupStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get estimatedPickupTime => $composableBuilder(
    column: $table.estimatedPickupTime,
    builder: (column) => column,
  );

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeliveryOrdersTable,
          DeliveryOrder,
          $$DeliveryOrdersTableFilterComposer,
          $$DeliveryOrdersTableOrderingComposer,
          $$DeliveryOrdersTableAnnotationComposer,
          $$DeliveryOrdersTableCreateCompanionBuilder,
          $$DeliveryOrdersTableUpdateCompanionBuilder,
          (DeliveryOrder, $$DeliveryOrdersTableReferences),
          DeliveryOrder,
          PrefetchHooks Function({bool orderId})
        > {
  $$DeliveryOrdersTableTableManager(
    _$AppDatabase db,
    $DeliveryOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliveryOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<String> platformOrderId = const Value.absent(),
                Value<double> commissionRate = const Value.absent(),
                Value<double> commissionAmount = const Value.absent(),
                Value<double> netPayout = const Value.absent(),
                Value<String?> riderName = const Value.absent(),
                Value<String?> riderPhone = const Value.absent(),
                Value<String> pickupStatus = const Value.absent(),
                Value<DateTime?> estimatedPickupTime = const Value.absent(),
              }) => DeliveryOrdersCompanion(
                id: id,
                orderId: orderId,
                channel: channel,
                platformOrderId: platformOrderId,
                commissionRate: commissionRate,
                commissionAmount: commissionAmount,
                netPayout: netPayout,
                riderName: riderName,
                riderPhone: riderPhone,
                pickupStatus: pickupStatus,
                estimatedPickupTime: estimatedPickupTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required String channel,
                required String platformOrderId,
                Value<double> commissionRate = const Value.absent(),
                Value<double> commissionAmount = const Value.absent(),
                Value<double> netPayout = const Value.absent(),
                Value<String?> riderName = const Value.absent(),
                Value<String?> riderPhone = const Value.absent(),
                Value<String> pickupStatus = const Value.absent(),
                Value<DateTime?> estimatedPickupTime = const Value.absent(),
              }) => DeliveryOrdersCompanion.insert(
                id: id,
                orderId: orderId,
                channel: channel,
                platformOrderId: platformOrderId,
                commissionRate: commissionRate,
                commissionAmount: commissionAmount,
                netPayout: netPayout,
                riderName: riderName,
                riderPhone: riderPhone,
                pickupStatus: pickupStatus,
                estimatedPickupTime: estimatedPickupTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeliveryOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$DeliveryOrdersTableReferences
                                    ._orderIdTable(db),
                                referencedColumn:
                                    $$DeliveryOrdersTableReferences
                                        ._orderIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeliveryOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeliveryOrdersTable,
      DeliveryOrder,
      $$DeliveryOrdersTableFilterComposer,
      $$DeliveryOrdersTableOrderingComposer,
      $$DeliveryOrdersTableAnnotationComposer,
      $$DeliveryOrdersTableCreateCompanionBuilder,
      $$DeliveryOrdersTableUpdateCompanionBuilder,
      (DeliveryOrder, $$DeliveryOrdersTableReferences),
      DeliveryOrder,
      PrefetchHooks Function({bool orderId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db, _db.menuItems);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$MenuItemIngredientsTableTableManager get menuItemIngredients =>
      $$MenuItemIngredientsTableTableManager(_db, _db.menuItemIngredients);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderItemsTableTableManager get orderItems =>
      $$OrderItemsTableTableManager(_db, _db.orderItems);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$StaffMembersTableTableManager get staffMembers =>
      $$StaffMembersTableTableManager(_db, _db.staffMembers);
  $$StaffAttendancesTableTableManager get staffAttendances =>
      $$StaffAttendancesTableTableManager(_db, _db.staffAttendances);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$PurchaseOrdersTableTableManager get purchaseOrders =>
      $$PurchaseOrdersTableTableManager(_db, _db.purchaseOrders);
  $$PurchaseOrderItemsTableTableManager get purchaseOrderItems =>
      $$PurchaseOrderItemsTableTableManager(_db, _db.purchaseOrderItems);
  $$StockAuditsTableTableManager get stockAudits =>
      $$StockAuditsTableTableManager(_db, _db.stockAudits);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$CashDrawerLogsTableTableManager get cashDrawerLogs =>
      $$CashDrawerLogsTableTableManager(_db, _db.cashDrawerLogs);
  $$SyncTombstonesTableTableManager get syncTombstones =>
      $$SyncTombstonesTableTableManager(_db, _db.syncTombstones);
  $$OutletsTableTableManager get outlets =>
      $$OutletsTableTableManager(_db, _db.outlets);
  $$StockTransfersTableTableManager get stockTransfers =>
      $$StockTransfersTableTableManager(_db, _db.stockTransfers);
  $$DeliveryOrdersTableTableManager get deliveryOrders =>
      $$DeliveryOrdersTableTableManager(_db, _db.deliveryOrders);
}
