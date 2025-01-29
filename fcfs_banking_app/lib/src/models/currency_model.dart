class CurrencyResponse {
  final Meta meta;
  final Map<String, Currency> data;

  CurrencyResponse({required this.meta, required this.data});

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    var dataMap = <String, Currency>{};
    json['data'].forEach((key, value) {
      dataMap[key] = Currency.fromJson(value);
    });

    return CurrencyResponse(
      meta: Meta.fromJson(json['meta']),
      data: dataMap,
    );
  }

  Map<String, dynamic> toJson() {
    var dataMap = <String, dynamic>{};
    data.forEach((key, value) {
      dataMap[key] = value.toJson();
    });

    return {
      'meta': meta.toJson(),
      'data': dataMap,
    };
  }
}

class Meta {
  final String lastUpdatedAt;

  Meta({required this.lastUpdatedAt});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      lastUpdatedAt: json['last_updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_updated_at': lastUpdatedAt,
    };
  }
}

class Currency {
  final String code;
  final double value;

  Currency({required this.code, required this.value});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      value: json['value'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'value': value,
    };
  }
}
