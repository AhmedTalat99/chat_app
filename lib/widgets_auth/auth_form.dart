import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFn;

  const AuthForm(this.submitFn, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _email = "";
  final String _password = "";
  String _username = "";

  void _submit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formkey.currentState?.save();
      print(_email);
      print(_username);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Minimize the amount of free space along the main axis
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  decoration:
                      const InputDecoration(label: Text('Email Address')),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(label: Text('Username')),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(label: Text('Password')),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 7) {
                      return "Password must be at least 7 characters";
                    }
                    return null;
                  },

                  obscureText: true,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
