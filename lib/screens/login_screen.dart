import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skip_the_streak/cubits/login_cubit.dart';
import 'package:skip_the_streak/cubits/password_visibility_cubit.dart';
import 'package:skip_the_streak/generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        // BlocProvider(create: (_) => PasswordCubit()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Image.asset(
                      'lib/assets/images/login_screen.png',
                      fit: BoxFit.cover,
                    )),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.4 * 0.15,
                  thickness: 0,
                ),
                BlocBuilder<LoginCubit, String>(
                  builder: (context, loginText) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: TextEditingController(text: loginText),
                        onChanged: (text) => context.read<LoginCubit>().updateLoginText(text),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: S.of(context).login_label,
                          suffixIcon: IconButton(
                            onPressed: () => context.read<LoginCubit>().clearLoginText(),
                            icon: const Icon(Icons.highlight_remove),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.4 * 0.05,
                  thickness: 0,
                ),
                BlocProvider(
                  create: (context) => PasswordObscureText(),
                  child: BlocBuilder<PasswordObscureText, bool>(
                    builder: (context, state) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          obscureText: state,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).password_label,
                              suffixIcon: IconButton(
                                  onPressed: () => context
                                      .read<PasswordObscureText>()
                                      .toggleVisibility(),
                                  icon: const Icon(
                                      Icons.remove_red_eye_outlined))),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.4 * 0.08,
                  thickness: 0,
                ),
                ElevatedButton(
                    onPressed: () {}, child: Text(S.of(context).login)),
                TextButton(
                    onPressed: () {}, child: Text(S.of(context).register)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
