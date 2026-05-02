import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/recommendations/data/recommendation_repository_impl.dart';
import 'package:kisansarthi/features/recommendations/domain/recommendation_repository.dart';
import 'package:kisansarthi/shared/models/recommendations.dart';

final recommendationRepositoryProvider = Provider<RecommendationRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RecommendationRepositoryImpl(dio);
});

final cropSuggestionsProvider = FutureProvider.family<List<CropSuggestion>, int>((ref, landId) async {
  final repository = ref.watch(recommendationRepositoryProvider);
  return repository.getCropSuggestions(landId);
});


