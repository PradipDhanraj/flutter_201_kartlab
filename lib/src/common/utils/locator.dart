import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/services/product_service/product_service.dart';
import 'package:get_it/get_it.dart';

GetIt get locator => GetIt.instance;
Future setupLocator() async {
  locator.registerLazySingleton<ProductService>(() => ProductServiceImplementation());
  var sharedService = SharedPreferenceImpl();
  await sharedService.init();
  locator.registerLazySingleton<SharePreferenceService>(() => sharedService);
}
