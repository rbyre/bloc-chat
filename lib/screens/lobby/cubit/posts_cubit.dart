import 'package:bloc_chat/data_service.dart';
import 'package:bloc_chat/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<List<Post>> {
  final _dataService = DataService();

  // initialize with empty list
  PostsCubit() : super([]);

  void getPosts() async => emit(await _dataService.getPosts());
}
