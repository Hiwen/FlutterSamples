import 'package:dio/dio.dart';
import 'HeWeather.dart';

class WeatherDataGetter {
  static const String basUrl = "https://free-api.heweather.com/s6/weather";
  static const String key = 'f7f45241497049abb268159da2c8cd57';

  static Dio dio = Dio(BaseOptions(baseUrl: basUrl));

  /**
   * 三天预报
   * cityName 城市名称 我们应该使用外部传入
   * net 监听网络请求的结果 因为他不是同步的
   */
  forecast(ResponseListener lst, String cityName) async {
    var response = await dio.get('/forecast', queryParameters: {
      'location': cityName,
      'key': key
    });
    print(response);
    lst.onForecastResponse(response.data);
  }

  /**
   * 获取实况天气
   */
  now(ResponseListener lst, String cityName) async {
    var response = await dio.get('/now', queryParameters: {
      'location': cityName,
      'key': key
    });
    print(response);
    lst.onNewWeatherResponse(response.data);
  }
}
