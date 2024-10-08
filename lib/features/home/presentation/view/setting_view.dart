import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/SignIn_Cubit/cubit/sign_in_cubit.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _nameController.text = currentUser!.displayName ?? '';
      _emailController.text = currentUser!.email ?? '';
    }
  }

  Future<void> _updateProfile() async {
    final cubit = context.read<SignInCubit>();
    await cubit.updateUserProfile(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required Function onEdit,
  }) {
    return Row(
      children: [
        Expanded(
          child: isEditing
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  '$label: ${controller.text}',
                  style: TextStyle(fontSize: 16),
                ),
        ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit),
          onPressed: () {
            if (isEditing) {
              _updateProfile();
            } else {
              onEdit();
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
      ),
      body: currentUser == null
          ? Center(child: Text('لا يوجد مستخدم مسجل الدخول'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      currentUser!.photoURL ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildEditableField(
                    label: 'اسم المستخدم',
                    controller: _nameController,
                    isEditing: _isEditingName,
                    onEdit: () {
                      setState(() {
                        _isEditingName = !_isEditingName;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _buildEditableField(
                    label: 'البريد الإلكتروني',
                    controller: _emailController,
                    isEditing: _isEditingEmail,
                    onEdit: () {
                      setState(() {
                        _isEditingEmail = !_isEditingEmail;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _buildEditableField(
                    label: 'كلمة المرور',
                    controller: _passwordController,
                    isEditing: _isEditingPassword,
                    onEdit: () {
                      setState(() {
                        _isEditingPassword = !_isEditingPassword;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  BlocListener<SignInCubit, SignInState>(
                    listener: (context, state) {
                      if (state is UpdateUserProfileSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم تحديث البيانات بنجاح')),
                        );
                      } else if (state is UpdateUserProfileFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('فشل في تحديث البيانات: ${state.errorMessage}')),
                        );
                      }
                    },
                    child: Container(),
                  ),
                ],
              ),
            ),
    );
  }
}
