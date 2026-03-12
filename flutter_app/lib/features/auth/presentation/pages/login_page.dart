import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

import 'register_page.dart';
import '../../../../home/home_page.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocConsumer<AuthCubit, AuthState>(

          listener: (context, state) {

            if (state is AuthSuccess) {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login Successful"),
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );

            }

            if (state is AuthError) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );

            }

          },

          builder: (context, state) {

            if (state is AuthLoading) {

              return const Center(
                child: CircularProgressIndicator(),
              );

            }

            return Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    onPressed: () {

                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields"),
                          ),
                        );

                        return;
                      }

                      context.read<AuthCubit>().login(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                    },

                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),

                  ),

                ),

                const SizedBox(height: 15),

                TextButton(

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(),
                      ),
                    );

                  },

                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 16),
                  ),

                ),

              ],

            );

          },

        ),

      ),

    );

  }

}