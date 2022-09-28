
import 'package:app_artistica/provider/app_state.dart';
import 'package:app_artistica/screens/check_auth_screen.dart';
import 'package:app_artistica/screens/introductionScreen/slider.dart';
import 'package:app_artistica/screens/login.dart';
import 'package:app_artistica/screens/navigator/inventory/categories/category_page.dart';
import 'package:app_artistica/screens/navigator/inventory/create_product.dart';
import 'package:app_artistica/screens/navigator/profile/customers/customers.dart';
import 'package:app_artistica/screens/navigator/profile/invoices/operations_screen.dart';
import 'package:app_artistica/screens/navigator/profile/setting_screen/setting_screen.dart';
import 'package:app_artistica/screens/navigator_bar.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:app_artistica/settings/theme_state_goods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'bloc/app_state/app_state_bloc.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/client/client_bloc.dart';
import 'bloc/contact/contact_bloc.dart';
import 'bloc/invoice/invoice_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/product_sold/product_sold_bloc.dart';
import 'bloc/selected_product/selected_product_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'screens/navigator/cart/billing/detail_payment.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
        BlocProvider(create: ( _ ) => AppStateBloc() ),
        BlocProvider(create: ( _ ) => UserBloc() ),
        BlocProvider(create: ( _ ) => CategoryBloc() ),
        BlocProvider(create: ( _ ) => ProductBloc() ),
        BlocProvider(create: ( _ ) => SelectedProductBloc() ),
        BlocProvider(create: ( _ ) => ClientBloc() ),
        BlocProvider(create: ( _ ) => InvoiceBloc() ),
        BlocProvider(create: ( _ ) => ContactBloc() ),
        BlocProvider(create: ( _ ) => ProductSoldBloc() ),
        
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => AppState()),
        ],
        child: ThemeProvider(
            saveThemesOnChange: true, // Auto save any theme change we do
            loadThemeOnInit: false, // Do not load the saved theme(use onInitCallback callback)
            onInitCallback: (controller, previouslySavedThemeFuture) async {
              String? savedTheme = await previouslySavedThemeFuture;

              if (savedTheme != null) {
                // If previous theme saved, use saved theme
                controller.setTheme(savedTheme);
              } else {
                // If previous theme not found, use platform default
                Brightness platformBrightness = SchedulerBinding.instance!.window.platformBrightness;
                if (platformBrightness == Brightness.dark) {
                  controller.setTheme('dark');
                } else {
                  controller.setTheme('light');
                }
                // Forget the saved theme(which were saved just now by previous lines)
                controller.forgetSavedTheme();
              }
            },
            themes: <AppTheme>[
              ligthGood(),
              darkGood(),
            ],
            child: ThemeConsumer(
                child: Builder(
              builder: (themeContext) => MaterialApp(
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('es', ''), // Spanish, no country code
                  ],
                  theme: ThemeProvider.themeOf(themeContext).data,
                  title: 'app_artistica',
                  debugShowCheckedModeBanner: false,
                  initialRoute: 'checking',
                  routes: {
                    'checking': (_) => const CheckAuthScreen(),
                    'home': (_) => const LoginScreen(),
                    'slider': (_) => const ScreenSlider(),
                    'navigator': (_) => const NavigatorBar(),
                    'category':(_) => const ScreenCategory(),
                    'settigs':(_) => const SettingScreen(),
                    'client':(_) => const Customers(),
                    'invoice':(_) => const OperationsScreen(),
                    'billing':(_) => const DetailCard(),
                    'product':(_) => const CreateProductScreen(),
                  }),
            )))));
  }
}
