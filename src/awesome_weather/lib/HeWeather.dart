


/**
 * 用来回调成功和失败的结果
 */
abstract class ResponseListener {
  //实况天气
  void onNewWeatherResponse(data);

  //三天预报
  void onForecastResponse(data);
  

  void onError(error);
}