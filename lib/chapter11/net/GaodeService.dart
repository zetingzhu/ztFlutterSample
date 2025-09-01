import 'package:dio/dio.dart';
import '../entiy/BaseGaodeWeather.dart';
import '../entiy/ForecastsDTO.dart';
import '../entiy/LivesDTO.dart';

class GaodeService {
  static const String _baseUrl =
      'https://restapi.amap.com/v3/weather/weatherInfo';
  static const String _apiKey = '0a53a908f0378845f8c11b9acb5fd2f2';

  static final Dio _dio = Dio();

  /// 获取天气信息
  /// [city] 城市编码，如：420600
  /// [extensions] 气象类型，可选值：base(实况天气) 或 all(预报天气)
  static Future<BaseGaodeWeather<ForecastsDTO, LivesDTO>?> getWeatherInfo({
    required String city,
    String extensions = 'all',
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'extensions': extensions,
          'city': city,
        },
      );

      print('请求URL: ${response.requestOptions.uri}');
      print('响应数据: ${response.data}');

      if (response.statusCode == 200) {
        return BaseGaodeWeather<ForecastsDTO, LivesDTO>.fromJson(
          response.data,
          fromJsonT: (json) => ForecastsDTO.fromJson(json),
          fromJsonU: (json) => LivesDTO.fromJson(json),
        );
      } else {
        print('请求失败，状态码: ${response.statusCode}');
        print('错误信息: ${response.data}');
        return null;
      }
    } catch (e) {
      print('网络请求异常: $e');
      return null;
    }
  }

  /// 获取实况天气
  static Future<BaseGaodeWeather<ForecastsDTO, LivesDTO>?> getLiveWeather(
    String city,
  ) {
    return getWeatherInfo(city: city, extensions: 'base');
  }

  /// 获取预报天气
  static Future<BaseGaodeWeather<ForecastsDTO, LivesDTO>?> getForecastWeather(
    String city,
  ) {
    return getWeatherInfo(city: city, extensions: 'all');
  }
}
