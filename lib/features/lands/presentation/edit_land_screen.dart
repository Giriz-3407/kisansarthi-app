import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_notifier.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/shared/models/land.dart';

class EditLandScreen extends ConsumerStatefulWidget {
  final Land land;
  const EditLandScreen({super.key, required this.land});

  @override
  ConsumerState<EditLandScreen> createState() => _EditLandScreenState();
}

class _EditLandScreenState extends ConsumerState<EditLandScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _areaController;
  late TextEditingController _unitController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.land.name);
    _typeController = TextEditingController(text: widget.land.landType);
    _areaController = TextEditingController(text: widget.land.area?.toString());
    _unitController = TextEditingController(text: widget.land.areaUnit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _areaController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final repository = ref.read(landRepositoryProvider);
        await repository.updateLand(
          widget.land.id,
          _nameController.text,
          landType: _typeController.text,
          area: double.tryParse(_areaController.text),
          areaUnit: _unitController.text,
        );
        ref.invalidate(landDetailProvider(widget.land.id));
        ref.invalidate(farmLandsProvider(widget.land.farmId));
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Land?'),
        content: const Text('This will remove all associated soil data and plantings.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _isLoading = true);
      try {
        final repository = ref.read(landRepositoryProvider);
        await repository.deleteLand(widget.land.id);
        ref.invalidate(farmLandsProvider(widget.land.farmId));
        if (mounted) {
          context.pop(); // Close edit
          context.pop(); // Back to farm detail
        }
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Land'),
        actions: [
          IconButton(onPressed: _delete, icon: const Icon(Icons.delete, color: Colors.red)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Land Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Land Type'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _areaController,
                      decoration: const InputDecoration(labelText: 'Area'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _unitController,
                      decoration: const InputDecoration(labelText: 'Unit'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _update,
                  child: const Text('Save Changes'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
