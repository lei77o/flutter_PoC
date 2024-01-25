import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/constant/environment.dart';
import 'package:teslo_shop/features/shared/shared.dart';

import '../providers/login_form_provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox( height: 80 ),
                // Icon Banner
                Center(
                  child: Image.asset('assets/images/mepco-logo.png'),
                ),
                const SizedBox( height: 80 ),

                Container(
                  height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _LoginForm(),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget  {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(loginFormProvider);

    final textStyles = Theme.of(context).textTheme;
    //final TextEditingController _usernameController = TextEditingController();
    //final TextEditingController _passwordController = TextEditingController();


    /*return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 50 ),
          Text('Login', style: textStyles.titleLarge ),
          const SizedBox( height: 90 ),

     *//*     const CustomTextFormField(
            label: 'User Name',
            keyboardType: TextInputType.emailAddress,
          ),*//*
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          const SizedBox( height: 30 ),

   *//*       const CustomTextFormField(
            label: 'Password',
            obscureText: true,
          ),*//*
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox( height: 30 ),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Login',
              buttonColor: Colors.blue,
              onPressed: (){
                ref.read(loginFormProvider.notifier).onFormSubmit();
             *//*     logIn(
                    _usernameController.text.trim(),
                    _passwordController.text.trim()
                  );*//*
              },
            )
          ),

          const Spacer( flex: 2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Forgot password?'),
              TextButton(
                onPressed: ()=> context.push('/register'), 
                child: const Text('Click here')
              )
            ],
          ),

          const Spacer( flex: 1),
        ],
      ),
    );*/

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 50 ),
          Text('Login', style: textStyles.titleLarge ),
          const SizedBox( height: 90 ),

          CustomTextFormField(
            label: 'Username',
            keyboardType: TextInputType.text,
            onChanged: ref.read(loginFormProvider.notifier).onUsernameChanged,
            errorMessage: loginForm.isFormPosted ?
            loginForm.username.errorMessage
                : null,
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Password',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ?
            loginForm.password.errorMessage
                : null,
          ),

          const SizedBox( height: 30 ),

          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Login',
                buttonColor: Colors.black,
                onPressed: (){
                  ref.read(loginFormProvider.notifier).onFormSubmit();
                },
              )
          ),

          const Spacer( flex: 2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Forgot your password?'),
              TextButton(
                  onPressed: ()=> context.push('/register'),
                  child: const Text('Click here')
              )
            ],
          ),

          const Spacer( flex: 1),
        ],
      ),
    );
  }

  logIn(String username, String password){
    AWSServices().createInitialRecord(username, password);
  }
}