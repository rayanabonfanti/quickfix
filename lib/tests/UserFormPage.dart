import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _addressNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Enter your details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Street'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your street';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cepController,
                    decoration: const InputDecoration(labelText: 'CEP'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your CEP';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressNumberController,
                    decoration: const InputDecoration(labelText: 'Number of Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ufController,
                    decoration: const InputDecoration(labelText: 'UF'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your UF';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);

                        // Insert address first
                        final response = await Supabase.instance.client.from('address').insert({
                          'number': _addressNumberController.text,
                          'street': _streetController.text,
                          'uf': _ufController.text,
                          'cep': _cepController.text,
                        }).select();

                        print('response: $response');

                        if (response.isEmpty) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(content: Text('Error inserting address')),
                          );
                          return;
                        }

                        final addressId = response[0]['id'];

                        print('addressId: $addressId');
                        // Insert user with addressId
                        final userResponse = await Supabase.instance.client.from('users').insert({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'phone': _phoneController.text,
                          'addressId': addressId,
                        }).select();

                        if (userResponse.isEmpty) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(content: Text('Error inserting user')),
                          );
                        } else {
                          navigator.pop();
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
