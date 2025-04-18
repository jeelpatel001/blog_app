import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [AppPallete.borderColor, AppPallete.backgroundColor, AppPallete.backgroundColor],
            center: Alignment.bottomLeft,
            radius: 2.3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthField(
                        hintText: 'Name',
                        textEditingController: nameController,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: 'Email',
                        textEditingController: emailController,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: 'Password',
                        textEditingController: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 20),
                      AuthGradientButton(
                        buttonText: "Sign Up",
                        onPressed:
                            () => {
                              if (formKey.currentState!.validate())
                                {
                                  context.read<AuthBloc>().add(
                                    AuthSignUp(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  ),
                                },
                            },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, LoginPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
