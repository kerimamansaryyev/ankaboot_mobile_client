import 'package:ankabootmobile/src/di/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'annotations.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
@injectableInit
Future<void> configureInjection(String env) async {
  await $initGetIt(serviceLocator, environment: env);
}

Future<void> initDependencies() async {
  await configureInjection(
    testEnv.name,
  );
  await serviceLocator.allReady();
}
