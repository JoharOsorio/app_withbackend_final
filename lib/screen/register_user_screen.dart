import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/services/auth_service.dart';
import 'package:app_withbackend_final/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app_withbackend_final/providers/providers.dart';
import '../ui/input_decorations.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
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
                  'Signup',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const RegisterForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text('Already have an account? Login'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return SignUpForm(loginForm: loginForm);
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.loginForm,
  });

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
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
                  final String? errorMessage = await authService.create_user(
                      loginForm.email, loginForm.password);
                  if (errorMessage == null) {
                    Navigator.pushNamed(context, 'login');
                  } else {
                    print(errorMessage);
                  }
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: const Text(
              'Signup',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
