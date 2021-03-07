import 'package:fluchat/data/auth_repository.dart';
import 'package:fluchat/data/image_picker_repository.dart';
import 'package:fluchat/data/local/auth_local_impl.dart';
import 'package:fluchat/data/local/image_picker_impl.dart';
import 'package:fluchat/data/local/persistent_storage_local_impl.dart';
import 'package:fluchat/data/local/stream_api_local_impl.dart';
import 'package:fluchat/data/local/upload_storage_local_impl.dart';
import 'package:fluchat/data/persistent_storage_repository.dart';
import 'package:fluchat/data/prod/auth_impl.dart';
import 'package:fluchat/data/prod/persistent_storage_impl.dart';
import 'package:fluchat/data/prod/stream_api_impl.dart';
import 'package:fluchat/data/prod/upload_storage_impl.dart';
import 'package:fluchat/data/stream_api_repository.dart';
import 'package:fluchat/data/upload_storage_repository.dart';
import 'package:fluchat/domain/usecases/create_group_usecase.dart';
import 'package:fluchat/domain/usecases/login_usecase.dart';
import 'package:fluchat/domain/usecases/logout_usecase.dart';
import 'package:fluchat/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(create: (_) => StreamApiImpl(client)),
    RepositoryProvider<PersistentStorageRepository>(create: (_) => PersistentStorageImpl()),
    RepositoryProvider<AuthRepository>(create: (_) => AuthImpl()),
    RepositoryProvider<UploadStorageRepository>(create: (_) => UploadStorageImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl()),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) => ProfileSignInUseCase(
        context.read(),
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}
