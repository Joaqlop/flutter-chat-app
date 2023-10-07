import 'package:chat_app/pages/pages.dart';

final appRoutes = {
  'chat': (_) => const ChatPage(),
  'loading': (_) => const LoadingPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'users': (_) => const UserPage(),
};
