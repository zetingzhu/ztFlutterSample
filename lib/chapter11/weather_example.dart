import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/util/ToastUtil.dart';
import 'net/GaodeService.dart';
import 'entiy/BaseGaodeWeather.dart';
import 'entiy/ForecastsDTO.dart';
import 'entiy/LivesDTO.dart';
import '../util/loading_dialog.dart';

class WeatherExample extends StatefulWidget {
  const WeatherExample({super.key});

  @override
  _WeatherExampleState createState() => _WeatherExampleState();
}

class _WeatherExampleState extends State<WeatherExample> {
  BaseGaodeWeather<ForecastsDTO, LivesDTO>? weatherData;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // 延迟一帧后显示弹框，确保页面已经构建完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshWeatherWithDialog();
    });
  }

  Future<void> refreshWeatherWithDialog() async {
    LoadingDialog.show(context);

    try {
      final data = await GaodeService.getForecastWeather('420600');
      setState(() {
        weatherData = data;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage = '加载天气数据失败: $e';
      });
    } finally {
      LoadingDialog.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高德天气示例'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshWeatherWithDialog,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 在按钮点击时显示 Toast
              // ToastUtil().showToast(context, 'Toast');
              // ToastUtil().showToast(context, '这是一个全局的 Toast 提示！');
              ToastUtil().showToast(context, '这是一个全局的 Toast 提示！这是一个全局的 Toast 提示！这是一个全局的 Toast 提示！');
            },
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (weatherData != null) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusInfo(),
            SizedBox(height: 20),
            _buildLiveWeather(),
            SizedBox(height: 20),
            _buildForecastWeather(),
          ],
        ),
      );
    }

    return Center(child: Text('暂无数据'));
  }

  Widget _buildStatusInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'API状态信息',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('状态: ${weatherData?.status ?? "未知"}'),
            Text('信息: ${weatherData?.info ?? "未知"}'),
            Text('信息码: ${weatherData?.infocode ?? "未知"}'),
            Text('数量: ${weatherData?.count ?? "未知"}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveWeather() {
    if (weatherData?.lives == null || weatherData!.lives!.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '实况天气',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...weatherData!.lives!
                .map(
                  (live) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('城市: ${live.city ?? "未知"}'),
                      Text('省份: ${live.province ?? "未知"}'),
                      Text('天气: ${live.weather ?? "未知"}'),
                      Text('温度: ${live.temperature ?? "未知"}°C'),
                      Text('湿度: ${live.humidity ?? "未知"}%'),
                      Text('风向: ${live.winddirection ?? "未知"}'),
                      Text('风力: ${live.windpower ?? "未知"}级'),
                      Text('报告时间: ${live.reporttime ?? "未知"}'),
                      Divider(),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastWeather() {
    if (weatherData?.forecasts == null || weatherData!.forecasts!.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '预报天气',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...weatherData!.forecasts!
                .map(
                  (forecast) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('城市: ${forecast.city ?? "未知"}'),
                      Text('省份: ${forecast.province ?? "未知"}'),
                      Text('报告时间: ${forecast.reporttime ?? "未知"}'),
                      SizedBox(height: 8),
                      ..._buildCastsList(forecast),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCastsList(ForecastsDTO forecast) {
    if (forecast.casts == null || forecast.casts!.isEmpty) {
      return [];
    }

    return forecast.casts!
        .map(
          (cast) => Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('日期: ${cast.date ?? "未知"} (${cast.week ?? "未知"})'),
                Text('白天天气: ${cast.dayweather ?? "未知"}'),
                Text('夜间天气: ${cast.nightweather ?? "未知"}'),
                Text('白天温度: ${cast.daytemp ?? "未知"}°C'),
                Text('夜间温度: ${cast.nighttemp ?? "未知"}°C'),
                Text('白天风向: ${cast.daywind ?? "未知"}'),
                Text('夜间风向: ${cast.nightwind ?? "未知"}'),
                Divider(),
              ],
            ),
          ),
        )
        .toList();
  }
}
