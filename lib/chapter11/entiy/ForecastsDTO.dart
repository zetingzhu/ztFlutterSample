/**
 * 天气预报详细信息类
 * 
 * 包含某一天的详细天气预报数据，包括白天和夜间的天气状况
 * 
 * @author: zeting
 * @date: 2025/9/1
 */
class CastsDTO {
  /// 日期，格式：YYYY-MM-DD
  String? date;

  /// 星期几
  String? week;

  /// 白天天气现象
  String? dayweather;

  /// 夜间天气现象
  String? nightweather;

  /// 白天温度
  String? daytemp;

  /// 夜间温度
  String? nighttemp;

  /// 白天风向
  String? daywind;

  /// 夜间风向
  String? nightwind;

  /// 白天风力
  String? daypower;

  /// 夜间风力
  String? nightpower;

  /// 白天温度（浮点数）
  String? daytempFloat;

  /// 夜间温度（浮点数）
  String? nighttempFloat;

  CastsDTO({
    this.date,
    this.week,
    this.dayweather,
    this.nightweather,
    this.daytemp,
    this.nighttemp,
    this.daywind,
    this.nightwind,
    this.daypower,
    this.nightpower,
    this.daytempFloat,
    this.nighttempFloat,
  });

  factory CastsDTO.fromJson(Map<String, dynamic> json) {
    return CastsDTO(
      date: json['date'],
      week: json['week'],
      dayweather: json['dayweather'],
      nightweather: json['nightweather'],
      daytemp: json['daytemp'],
      nighttemp: json['nighttemp'],
      daywind: json['daywind'],
      nightwind: json['nightwind'],
      daypower: json['daypower'],
      nightpower: json['nightpower'],
      daytempFloat: json['daytemp_float'],
      nighttempFloat: json['nighttemp_float'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['week'] = week;
    data['dayweather'] = dayweather;
    data['nightweather'] = nightweather;
    data['daytemp'] = daytemp;
    data['nighttemp'] = nighttemp;
    data['daywind'] = daywind;
    data['nightwind'] = nightwind;
    data['daypower'] = daypower;
    data['nightpower'] = nightpower;
    data['daytemp_float'] = daytempFloat;
    data['nighttemp_float'] = nighttempFloat;
    return data;
  }

  @override
  String toString() {
    return 'CastsDTO{date: $date, dayweather: $dayweather, nightweather: $nightweather}';
  }
}

/**
 * 天气预报数据类
 * 
 * 包含某个城市的天气预报信息，包含多天的预报数据
 * 
 * @author: zeting
 * @date: 2025/9/1
 */
class ForecastsDTO {
  /// 城市名称
  String? city;

  /// 城市编码
  String? adcode;

  /// 省份名称
  String? province;

  /// 预报发布时间
  String? reporttime;

  /// 预报数据列表，包含未来几天的天气预报
  List<CastsDTO>? casts;

  ForecastsDTO({
    this.city,
    this.adcode,
    this.province,
    this.reporttime,
    this.casts,
  });

  factory ForecastsDTO.fromJson(Map<String, dynamic> json) {
    return ForecastsDTO(
      city: json['city'],
      adcode: json['adcode'],
      province: json['province'],
      reporttime: json['reporttime'],
      casts: (json['casts'] as List<dynamic>?)
          ?.map((e) => CastsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['adcode'] = adcode;
    data['province'] = province;
    data['reporttime'] = reporttime;
    if (casts != null) {
      data['casts'] = casts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'ForecastsDTO{city: $city, adcode: $adcode, province: $province, reporttime: $reporttime, casts: $casts}';
  }
}
