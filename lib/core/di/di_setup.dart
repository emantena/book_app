import 'package:get_it/get_it.dart';

import 'modules/auth_di_module.dart';
import 'modules/book_di_module.dart';
import 'modules/core_di_module.dart';
import 'modules/firebase_di_module.dart';
import 'modules/profile_di_module.dart';
import 'modules/search_di_module.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await CoreDiModule.init(sl);

  await FirebaseDiModule.init(sl);

  await AuthDiModule.init(sl);
  await BookDiModule.init(sl);
  await ProfileDiModule.init(sl);
  await SearchDiModule.init(sl);
}
