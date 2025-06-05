import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../controllers/empresa_controller.dart';

class EmpresaFormScreen extends StatefulWidget {
  final Empresa? empresa;
  const EmpresaFormScreen({super.key, this.empresa});

  @override
  State<EmpresaFormScreen> createState() => _EmpresaFormScreenState();
}

class _EmpresaFormScreenState extends State<EmpresaFormScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _cnpj = TextEditingController();
  final _tel = TextEditingController();
  final _ctrl = EmpresaController();

  @override
  void initState() {
    super.initState();
    if (widget.empresa != null) {
      _nome.text = widget.empresa!.nome;
      _cnpj.text = widget.empresa!.cnpj;
      _tel.text = widget.empresa!.telefone;
    }
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text(widget.empresa == null ? 'Nova Empresa' : 'Editar Empresa')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome')),
            TextFormField(controller: _cnpj, decoration: const InputDecoration(labelText: 'CNPJ')),
            TextFormField(controller: _tel, decoration: const InputDecoration(labelText: 'Telefone')),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                if (!_form.currentState!.validate()) return;
                final e = Empresa(
                  id: widget.empresa?.id,
                  nome: _nome.text,
                  cnpj: _cnpj.text,
                  telefone: _tel.text,
                  idUsuario: /*id do usuário atual*/,
                );
                if (widget.empresa == null) {
                  await _ctrl.inserir(e);
                } else {
                  await _ctrl.atualizar(e);
                }
                Navigator.pop(ctx, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
