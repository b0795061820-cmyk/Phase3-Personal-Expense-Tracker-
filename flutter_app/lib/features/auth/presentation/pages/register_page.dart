import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterPage extends StatelessWidget {

  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocConsumer<AuthCubit, AuthState>(

          listener: (context, state) {

            if (state is AuthSuccess) {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Account created successfully")),
              );

              Navigator.pop(context);
            }

            if (state is AuthError) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }

          },

          builder: (context, state) {

            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(

              children: [

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                ElevatedButton(

                  onPressed: () {

                    context.read<AuthCubit>().register(

                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,

                    );

                  },

                  child: const Text("Register"),

                ),

              ],

            );

          },

        ),

      ),

    );

  }

}