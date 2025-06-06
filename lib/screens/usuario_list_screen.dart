import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../controllers/usuario_controller.dart';
import 'usuario_form_screen.dart';

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({super.key});

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  final UsuarioController _controller = UsuarioController();
  List<Usuario> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  Future<void> _carregarUsuarios() async {
    final lista = await _controller.listarUsuarios();
    setState(() => _usuarios = lista);
  }

  Future<void> _abrirFormularioUsuario() async {
    // Aqui, sem 'const' na chamada
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => UsuarioFormScreen()),
    );
    // Se a tela de formulário retornou `true`, recarregamos
    if (resultado == true) {
      _carregarUsuarios();
    }
  }

  void _confirmarExclusao(Usuario usuario) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir usuário?'),
        content: Text('Deseja realmente excluir "${usuario.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _controller.excluirUsuario(usuario.id!);
              Navigator.pop(ctx);
              _carregarUsuarios();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: _usuarios.isEmpty
          ? const Center(child: Text('Nenhum usuário cadastrado'))
          : ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          final usuario = _usuarios[index];
          return ListTile(
            title: Text(usuario.nome),
            subtitle: Text(usuario.email),
            onLongPress: () => _confirmarExclusao(usuario),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormularioUsuario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
