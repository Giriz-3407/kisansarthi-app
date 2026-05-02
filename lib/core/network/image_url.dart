import 'package:kisansarthi/core/config/env_config.dart';

String? fixImageUrl(String? url) {
  if (url == null) return null;
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }

  final normalized = trimmed.replaceAll('\\', '/');
  final uploadsPath = normalized.startsWith('/uploads/')
      ? normalized
      : normalized.startsWith('uploads/')
          ? '/$normalized'
          : null;
  if (uploadsPath == null || !EnvConfig.isConfigured) return trimmed;

  final apiBase = EnvConfig.apiBaseUrl;
  final serverBase = apiBase.endsWith('/api/v1')
      ? apiBase.substring(0, apiBase.length - '/api/v1'.length)
      : apiBase;
  return '$serverBase$uploadsPath';
}
