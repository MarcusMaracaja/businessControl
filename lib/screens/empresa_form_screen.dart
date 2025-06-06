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

  final int _idUsuario = 1; // <-- Substitua com o ID real do usuário logado

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
  void dispose() {
    _nome.dispose();
    _cnpj.dispose();
    _tel.dispose();
    super.dispose();
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
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
            ),
            TextFormField(
              controller: _cnpj,
              decoration: const InputDecoration(labelText: 'CNPJ'),
              validator: (v) => v == null || v.isEmpty ? 'Informe o CNPJ' : null,
            ),
            TextFormField(
              controller: _tel,
              decoration: const InputDecoration(labelText: 'Telefone'),
              validator: (v) => v == null || v.isEmpty ? 'Informe o telefone' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                if (!_form.currentState!.validate()) return;
                final e = Empresa(
                  id: widget.empresa?.id,
                  nome: _nome.text.trim(),
                  cnpj: _cnpj.text.trim(),
                  telefone: _tel.text.trim(),
                  idUsuario: _idUsuario,
                );
                if (widget.empresa == null) {
                  await _ctrl.salvarEmpresa(e);
                } else {
                  await _ctrl.atualizarEmpresa(e);
                }
                if (context.mounted) Navigator.pop(ctx, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
