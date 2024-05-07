import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:movie_bloc/src/features/common/constants.dart';
import 'package:movie_bloc/src/features/common/data/models/character_model.dart';

import 'logging_interceptor.dart';

final _logger = Logger("API_SERVICE");
class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  ApiService() {
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      final response = await _dio.get(AppConstants.allCharactersEndpoint);
      final result = response.data['results'] as List;
      final List<CharacterModel> listOfCharacters =
          result.map((e) => CharacterModel.fromJson(e)).toList();
      return listOfCharacters;
    } on Exception catch (exp) {
      _logger.info("Exception Occured : ${exp.toString()}");
      throw Exception("Exception Occured : ${exp.toString()}");
    }
  }

  Future<List<CharacterModel>> getPagedCharacters(int page) async {
    try{
      final response = await _dio.get(AppConstants.allCharactersEndpoint, queryParameters: {'page' : page});
      final result = response.data['results'] as List;
      final List<CharacterModel> listOfCharacters =
          result.map((e) => CharacterModel.fromJson(e)).toList();
      return listOfCharacters;
    }
    on Exception catch(exp){
      _logger.info("Exception Occured : ${exp.toString()}");
      throw Exception("Exception Occured : ${exp.toString()}");
    }
  }
}
