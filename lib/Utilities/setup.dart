import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/layers/location_data.dart';
import 'package:glowup/Styles/theme.dart';

Future<void> setup() async {
  // Alternatively you could write it if you don't like global variables
  GetIt.I.registerSingletonAsync<SupabaseConnect>(() async {
    await dotenv.load(fileName: ".env");

    SupabaseConnect supabaseConnect = SupabaseConnect();
    await supabaseConnect.init();

    return supabaseConnect;
  });
  GetIt.I.registerSingleton<LocationData>(LocationData());
  GetIt.I.registerSingleton<ThemeManager>(ThemeManager());
  await EasyLocalization.ensureInitialized();

  await GetIt.I.allReady();
}
