import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project_splenta/Bloc/state_bloc.dart';

import '../Repository/ApiService.dart';
import 'event_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostLoading()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError('Failed to fetch posts. Please try again.'));
      }
    });
  }
}