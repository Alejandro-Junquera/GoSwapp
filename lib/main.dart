// ignore_for_file: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aplicacion_ganadora/providers/providers.dart';
import 'package:flutter_aplicacion_ganadora/screens/screens.dart';
import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CiclosService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NuevoProfProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NuevaTareaFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TeacherService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ComentarioFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AlumnoService(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoSwap',
          initialRoute: 'inicio',
          routes: {
            'inicio': (_) => const InicioScreen(),
            'login': (_) => const LoginScreen(),
            'registro': (_) => const RegistroScreen(),
            'initProf': (_) => const OfertasProfScreen(),
            'cliente': (_) => const ClienteScreen(),
            'nuevaOfertaCliente': (_) => const NuevaOfertaClienteScreen(),
            'admin': (_) => const OfertasAdminScreen(),
            'crearProfesor': (_) => const CrearProfresorScreen(),
            'alumno': (_) => AlumnoScreen(),
            'infoOfertaCliente': (_) => const InfoOfertaClienteScreen(),
            'googleMap': (_) => const GoogleMapScreen(),
            'perfilProfesor': (_) => const ProfesorPerfilScreen(),
            'perfilAlumno': (_) => const AlumnoPerfilScreen(),
            'perfilCliente': (_) => const ClientePerfilScreen(),
            'guiaAdmin': (_) => const GuiaAdminScreen(),
            'guiaUser': (_) => const GuiaUserScreen(),
            'guiaProfesor': (_) => const GuiaProfesorScreen(),
          },
          theme: ThemeData.light()
              .copyWith(scaffoldBackgroundColor: Colors.grey[200])),
    );
  }
}
