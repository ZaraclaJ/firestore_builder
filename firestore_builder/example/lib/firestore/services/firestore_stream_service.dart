import 'package:example/firestore/services/firestore_reference_service.dart';

class FirestoreStreamService {
  const FirestoreStreamService(
      {required FirestoreReferenceService referenceService})
      : _referenceService = referenceService;

  final FirestoreReferenceService _referenceService;
}
