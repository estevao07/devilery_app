import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/pages/auth/register/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocConsumer<RegisterController, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.loading) {
            showLoader();
          }

          if (state.status == RegisterStatus.error) {
            hideLoader();
            showError('Erro ao registrar usuário');
          }

          if (state.status == RegisterStatus.success) {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cadastro',
                        style: context.textStyles.textTitle,
                      ),
                      Text(
                        'Preencha os campos abaixo para criar o seu cadastro',
                        style: context.textStyles.textMedium
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: Validatorless.required('Nome obrigatório'),
                        controller: _nameEC,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Senha'),
                        controller: _passwordEC,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(
                              6, 'Senha deve conter pelo menos 6 caracteres'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Confirmar Senha'),
                        validator: Validatorless.multiple([
                          Validatorless.required('Confirmar senha obrigatória'),
                          Validatorless.compare(
                              _passwordEC, 'Senhas não conferem')
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: DeliveryButton(
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            if (valid) {
                              controller.register(_nameEC.text, _emailEC.text,
                                  _passwordEC.text);
                            }
                          },
                          label: 'Cadastrar',
                          width: double.infinity,
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
