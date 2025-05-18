import 'dart:math';
import 'dart:typed_data';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:screenwise/screenwise.dart';
import '../../../../ui/widgets/snackbar.dart';
import '../../../../presentation/shared/widgets/custom_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Uint8List? imgPath;
  String? imgName;
  String _resultMessage = " "; // رسالة النتيجة

  Future<void> uploadImage(ImageSource source) async {
    try {
      final pickedImg = await ImagePicker().pickImage(source: source);
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = "${Random().nextInt(108800)}${basename(pickedImg.path)}";
        });
      } else {
        showSnackBar(context, "No image selected.");
      }
    } catch (e) {
      showSnackBar(context, "Error occurred while picking image: $e");
    }
  }

  void showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  uploadImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  uploadImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          showSnackBar(context, state.message.toString());
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        } else if (state is AuthError) {
          showSnackBar(context, state.message.toString());
        }
        if (state is AuthLoading) {
          showSnackBar(context, "Loading...");
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 251, 232, 232),
              ),
              child: Stack(
                children: [
                  (imgPath == null)
                      ? CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.network(
                            'https://www.w3schools.com/w3images/avatar2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      : ClipOval(
                        child: Image.memory(
                          imgPath!,
                          width: 145,
                          height: 145,
                          fit: BoxFit.cover,
                        ),
                      ),
                  Positioned(
                    bottom: -6,
                    right: -12,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: showImageSourceOptions,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(_nameController, 'Full Name', Icons.person),
            const SizedBox(height: 20),
            _buildTextField(_emailController, 'Email Address', Icons.email),
            const SizedBox(height: 20),
            _buildTextField(
              _passwordController,
              'Password',
              Icons.lock,
              obscure: true,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              _confirmPasswordController,
              'Confirm Password',
              Icons.lock_outline,
              obscure: true,
            ),
            const SizedBox(height: 30),
            ResponsiveContainer(
              mobileWidthFraction: 1.0, 
              tabletWidthFraction: 0.55,
              desktopWidthFraction: 0.36,
              child: CustomElevatedButton(
                text: 'Sign Up',
                onPressed: () {
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    setState(() {
                      _resultMessage = "❌ كلمة المرور غير متطابقة.";
                    });
                    return;
                  }
                      
                  context.read<AuthCubit>().signUp(
                    email: _emailController.text.trim(),
                    password: _passwordController.text,
                    username: _nameController.text.trim(),
                    imageBytes: imgPath,
                    imageName: imgName,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(_resultMessage, style: const TextStyle(color: Colors.red)),
        
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already Have an Account?",
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                  child: const Text(
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.bold  ,color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return   ResponsiveContainer(
                  mobileWidthFraction: 1.0,
                  tabletWidthFraction: 0.55,
                  desktopWidthFraction: 0.36,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
