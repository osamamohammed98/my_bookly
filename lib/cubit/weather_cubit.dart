import 'package:bloc/bloc.dart';
import 'package:bloc_basic/models/weather_model.dart';
import 'package:bloc_basic/services/weather_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {


  WeatherCubit(this.weatherService) : super(WeatherInitialState());

  final WeatherService weatherService;

  static WeatherCubit instance(context) =>
      BlocProvider.of<WeatherCubit>(context);

  WeatherModel? weatherModel;
  String? cityName;

  Future<void> getWeather({required String cityName}) async {
   this.cityName = cityName;
    emit(WeatherLoadingState());
    weatherService.getWeather(cityName: cityName).then((value) {
      weatherModel = value;
      emit(WeatherSuccessState());
    }).catchError((onError) {
      emit(WeatherErrorState());
    });
  }
}
