import 'package:app_withbackend_final/services/auth_service.dart';
import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app_withbackend_final/providers/providers.dart';
import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CardContainer(
                  child: Column(children: [
                const SizedBox(height: 10),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const LoginForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'add_user'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text('Do not have an account? Sign up'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputDecortions.authInputDecoration(
            hinText: 'Please enter your email address',
            labelText: 'Email',
            prefixIcon: Icons.people,
          ),
          onChanged: (value) => loginForm.email = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'username cannot be empty';
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecortions.authInputDecoration(
            hinText: '************',
            labelText: 'Password',
            prefixIcon: Icons.lock_outline,
          ),
          onChanged: (value) => loginForm.password = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'password cannot be empty';
          },
        ),
        const SizedBox(height: 30),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledColor: Colors.grey,
          color: MyTheme.primary,
          elevation: 0,
          onPressed: loginForm.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final authService =
                      Provider.of<AuthService>(context, listen: false);
                  if (!loginForm.isValidForm()) return;
                  loginForm.isLoading = true;
                  final String? errorMessage = await authService.login(
                      loginForm.email, loginForm.password);
                  if (errorMessage == null) {
                    Navigator.pushNamed(context, 'list_product');
                  } else {
                    print(errorMessage);
                  }
                  loginForm.isLoading = false;
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
