/**
 * 实况天气数据类
 * 
 * 包含某个城市的实时天气信息
 * 
 * @author: zeting
 * @date: 2025/9/1
 */
class LivesDTO {
  /// 省份名称
  String? province;

  /// 城市名称
  String? city;

  /// 城市编码
  String? adcode;

  /// 天气现象（文字描述）
  String? weather;

  /// 实时气温，单位：摄氏度
  String? temperature;

  /// 风向描述
  String? winddirection;

  /// 风力等级，单位：级
  String? windpower;

  /// 空气湿度
  String? humidity;

  /// 数据发布的时间
  String? reporttime;

  /// 实时气温（浮点数）
  String? temperatureFloat;

  /// 空气湿度（浮点数）
  String? humidityFloat;

  LivesDTO({
    this.province,
    this.city,
    this.adcode,
    this.weather,
    this.temperature,
    this.winddirection,
    this.windpower,
    this.humidity,
    this.reporttime,
    this.temperatureFloat,
    this.humidityFloat,
  });

  factory LivesDTO.fromJson(Map<String, dynamic> json) {
    return LivesDTO(
      province: json['province'],
      city: json['city'],
      adcode: json['adcode'],
      weather: json['weather'],
      temperature: json['temperature'],
      winddirection: json['winddirection'],
      windpower: json['windpower'],
      humidity: json['humidity'],
      reporttime: json['reporttime'],
      temperatureFloat: json['temperature_float'],
      humidityFloat: json['humidity_float'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province'] = province;
    data['city'] = city;
    data['adcode'] = adcode;
    data['weather'] = weather;
    data['temperature'] = temperature;
    data['winddirection'] = winddirection;
    data['windpower'] = windpower;
    data['humidity'] = humidity;
    data['reporttime'] = reporttime;
    data['temperature_float'] = temperatureFloat;
    data['humidity_float'] = humidityFloat;
    return data;
  }

  @override
  String toString() {
    return 'LivesDTO{province: $province, city: $city, weather: $weather, reporttime: $reporttime}';
  }
}
