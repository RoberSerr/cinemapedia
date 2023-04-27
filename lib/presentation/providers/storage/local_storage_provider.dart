import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository.dart';


final localStorageRepositoryProvider = Provider((ref) 
  => LocalStorageRepositoryImpl( IsarDatasource() ));