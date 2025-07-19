


import 'package:chat_app/features/chats/data/repositories/chat_repositories.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:chat_app/features/conversation/domain/repositories/message_repo.dart';
import 'package:chat_app/features/login/data/repositories/login_repository.dart';
import 'package:chat_app/features/login/domain/repositories/login_repo.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chat_app/features/signup/data/repositories/signup_repository.dart';
import 'package:chat_app/features/signup/domain/repositories/signup_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/add_friend/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import '../../features/add_friend/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import '../../features/chats/presentation/bloc/get_user_bloc/get_friend_list_bloc.dart';
import '../../features/chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import '../../features/conversation/presentation/bloc/message_bloc.dart';
import '../../features/conversation/presentation/send_bloc/send_bloc.dart';
import '../../features/login/presentation/bloc/sign_in_bloc.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/signup/presentation/bloc/sign_up_bloc.dart';
import '../../features/splash/presentation/bloc/authentication_bloc.dart';

final getIt= GetIt.instance;


void setupServiceLocator(){

  //register the repository
  getIt.registerLazySingleton<SignupRepo>(()=>SignupRepoImpl());
  getIt.registerLazySingleton<LogInRepo>(()=>LoginRepoImpl());
  getIt.registerLazySingleton<ChatRepo>(()=>ChatRepoImpl());
  getIt.registerLazySingleton<ProfileRepo>(()=>ProfileRepoImpl());
  getIt.registerLazySingleton<MessageRepo>(()=>MessageRepoImpl());


  //register the bloc
  getIt.registerFactory(() => AuthenticationBloc(loginRepo: getIt()));
  getIt.registerFactory(() => SignInBloc(loginRepo: getIt()));
  getIt.registerFactory(() => SignUpBloc(signUpRepo: getIt()));
  getIt.registerFactory(() => GetFriendListBloc(chatRepo: getIt()));
  getIt.registerFactory(() => ProfileBloc(profileRepo: getIt()));
  getIt.registerFactory(() => MessageBloc(messageRepositories: getIt()));
  getIt.registerFactory(() => SendBloc(messageRepositories: getIt()));
  getIt.registerFactory(() => SearchUserBloc(chatRepo: getIt()));
  getIt.registerFactory(() => AddUserBloc(chatRepo: getIt()));
  getIt.registerFactory(() => OnlineUserBloc());
}
