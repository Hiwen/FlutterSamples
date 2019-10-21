import 'dart:convert';
import 'dart:io';

/**
 * 用来处理http请求和响应
 */
class httpManager {
//  三天预报
  var forecast_url = "https://free-api.heweather.com/s6/weather/forecast?parameters";
  //实况天气
  var new_weather_url =
      "https://free-api.heweather.com/s6/weather/now?parameters";

  /**
   * 三天预报
   * cityName 城市名称 我们应该使用外部传入
   * net 监听网络请求的结果 因为他不是同步的
   */
 getForecast(NetListener net,String cityName) async  {

         var url=forecast_url;
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      //var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
  }

  /**
   * 获取实况天气
   */
  getNewWeather(NetListener net,String cityName) async  {
    
         var url=new_weather_url;
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
  }
}

/**
 * 用来回调成功和失败的结果
 */
abstract class NetListener {
  //实况天气
  void onNewWeatherResponse(String body);
  //三天预报
  void onForecastResponse(String body);

  void onError(error);
}
