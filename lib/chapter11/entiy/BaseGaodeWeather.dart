import 'ForecastsDTO.dart';
import 'LivesDTO.dart';

/**
 * 高德天气API响应基础类
 *
 * 这是一个泛型类，用于包装高德天气API的响应数据
 * T 类型通常为 ForecastsDTO（预报天气数据）
 * U 类型通常为 LivesDTO（实况天气数据）
 * @author: zeting
 * @date: 2025/9/1
 */
class BaseGaodeWeather<T, U> {
  /// API请求状态，"1"表示成功，"0"表示失败
  String? status;
  
  /// 返回结果总数目
  String? count;
  
  /// 返回的状态信息，如"OK"表示成功
  String? info;
  
  /// 返回状态说明，10000代表正确
  String? infocode;
  
  /// 预报天气信息数组，当extensions=all时返回
  /// 包含未来几天的天气预报数据
  List<T>? forecasts;
  
  /// 实况天气信息数组，当extensions=base时返回
  /// 包含当前的实时天气数据
  List<U>? lives;

  /// 构造函数
  /// 
  /// 创建一个BaseGaodeWeather实例
  /// 所有参数都是可选的，支持部分数据初始化
  BaseGaodeWeather({
    this.status,
    this.count,
    this.info,
    this.infocode,
    this.forecasts,
    this.lives,
  });

  /// 从JSON数据创建BaseGaodeWeather实例的工厂构造函数
  /// 
  /// 由于Dart的泛型类型擦除特性，无法在运行时直接获取T和U的具体类型
  /// 因此需要传入具体的类型转换函数来处理JSON反序列化
  /// 
  /// [json] API响应的JSON数据
  /// [fromJsonT] T类型的JSON转换函数，如 ForecastsDTO.fromJson
  /// [fromJsonU] U类型的JSON转换函数，如 LivesDTO.fromJson
  /// 
  /// 返回解析后的BaseGaodeWeather实例
  factory BaseGaodeWeather.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) fromJsonT,
    required U Function(Map<String, dynamic>) fromJsonU,
  }) {
    return BaseGaodeWeather<T, U>(
      status: json['status'] as String?,
      count: json['count'] as String?,
      info: json['info'] as String?,
      infocode: json['infocode'] as String?,
      // 处理forecasts数组，将每个元素转换为T类型
      forecasts: (json['forecasts'] as List<dynamic>?)
          ?.map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      // 处理lives数组，将每个元素转换为U类型
      lives: (json['lives'] as List<dynamic>?)
          ?.map((e) => fromJsonU(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// 将BaseGaodeWeather实例转换为JSON数据
  /// 
  /// 同样由于泛型类型擦除，需要传入具体的类型转换函数
  /// 通常在应用中反向转换的需求较少，主要用于数据持久化或网络传输
  /// 
  /// [toJsonT] T类型的JSON转换函数，如 (forecast) => forecast.toJson()
  /// [toJsonU] U类型的JSON转换函数，如 (live) => live.toJson()
  /// 
  /// 返回可序列化的Map对象
  Map<String, dynamic> toJson({
    required Map<String, dynamic> Function(T) toJsonT,
    required Map<String, dynamic> Function(U) toJsonU,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    data['info'] = info;
    data['infocode'] = infocode;
    
    // 如果forecasts不为空，将每个元素转换为JSON
    if (forecasts != null) {
      data['forecasts'] = forecasts!.map((v) => toJsonT(v)).toList();
    }
    
    // 如果lives不为空，将每个元素转换为JSON
    if (lives != null) {
      data['lives'] = lives!.map((v) => toJsonU(v)).toList();
    }
    
    return data;
  }

  /// 重写toString方法，用于调试和日志输出
  /// 
  /// 返回包含主要字段信息的字符串表示
  @override
  String toString() {
    return 'BaseGaodeWeather{status: $status, count: $count, info: $info, infocode: $infocode, forecasts: $forecasts, lives: $lives}';
  }
}