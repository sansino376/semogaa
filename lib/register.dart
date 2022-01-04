import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  String email = '', password = '', npm = '', nama = '';

  void registers() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  formField(
                    'E-mail',
                    _emailController,
                    email,
                    Icons.email_rounded,
                  ),
                  formField(
                    'Password',
                    _passwordController,
                    password,
                    Icons.lock,
                  ),
                  formField('Nama Lengkap', _namaController, nama,
                      Icons.perm_identity),
                  formField(
                    'NPM',
                    _npmController,
                    npm,
                    Icons.format_list_numbered,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // try {
                        //   if (_formLoginKey.currentState!.validate()) {
                        //     login(
                        //         _emailController.text, _passwordController.text);
                        //     setState(() {});

                        //     // _usernameController.clear();
                        //     // _passwordController.clear();
                        //   }
                        // } catch (e) {
                        //   print('Error: $e');
                        // }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formField(
    String title,
    TextEditingController controller,
    //String onChanged,
    String valueChange,
    IconData icon,
  ) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return controller.text.isEmpty
            ? 'Form kosong, silahkan masukkan email'
            : null;
      },
      controller: controller,
      onChanged: (value) => value = value,
      cursorColor: Colors.green,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        //labelText: S.of(parentContext).username,
        labelText: title,
        labelStyle: const TextStyle(color: Colors.green),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(icon, color: Colors.green),
      ),
    );
  }
}
