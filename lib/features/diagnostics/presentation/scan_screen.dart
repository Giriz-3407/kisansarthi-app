import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/diagnostics/presentation/diagnostics_notifier.dart';
import 'package:kisansarthi/shared/widgets/connection_status_dot.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key, this.landId});

  final int? landId;

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  File? _image;
  bool _isUploading = false;
  final _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _upload() async {
    if (_image == null) return;
    final landId = widget.landId;
    if (landId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please open diagnosis from a land first')),
      );
      return;
    }

    final selectedCrop = await readLandScopedCrop(ref, landId);
    if (selectedCrop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a crop first')),
      );
      return;
    }

    setState(() => _isUploading = true);
    try {
      final repository = ref.read(diagnosticRepositoryProvider);
      print("Selected crop: ${selectedCrop.name}");
      final logId = await repository.scanPlant(
        _image!,
        landId: landId,
        cropName: selectedCrop.name,
      );
      if (mounted) {
        context.push('/diagnostics/result/$logId');
      }
    } catch (e) {
      String message = 'Upload failed. Please try again.';
      if (e is DioException &&
          (e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout ||
              e.type == DioExceptionType.connectionTimeout)) {
        message = 'Diagnosis is taking longer than expected. Please try again in a moment.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCrop = widget.landId == null
        ? null
        : ref.watch(landCropProvider(widget.landId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Diagnosis'),
        actions: const [ConnectionStatusDot()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedCrop != null) ...[
              Chip(
                avatar: const Icon(Icons.eco, size: 18),
                label: Text('Selected crop (for this land): ${selectedCrop.name}'),
              ),
              const SizedBox(height: 16),
            ],
            if (_image != null)
              Image.file(_image!, height: 300)
            else
              const Icon(Icons.image, size: 100, color: Colors.grey),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_isUploading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Uploading image and starting diagnosis...'),
                ],
              )
            else if (_image != null)
              ElevatedButton(
                onPressed: _upload,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Analyze Plant'),
              ),
          ],
        ),
      ),
    );
  }
}
