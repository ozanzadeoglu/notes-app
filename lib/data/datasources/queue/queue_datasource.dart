import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/utils/result.dart';
import 'package:connectinno_case_client/data/models/queue/queue_model.dart';


abstract class QueueDataSource {
  Future<Result<List<QueueModel>>> getAllQueueItems();
  Future<Result<void>> addToQueue(QueueModel queueItem);
  Future<Result<void>> removeFromQueue(String queueKey);
}

class QueueDataSourceImpl implements QueueDataSource {
  final ICacheService _cacheService;

  QueueDataSourceImpl(this._cacheService);

  @override
  Future<Result<List<QueueModel>>> getAllQueueItems() async {
    return _cacheService.getAll();
  }

  @override
  Future<Result<void>> addToQueue(QueueModel queueItem) async {
    return await _cacheService.put(queueItem.queueKey, queueItem);
  }

  @override
  Future<Result<void>> removeFromQueue(String queueKey) async {
    return _cacheService.delete(queueKey);
  }
}