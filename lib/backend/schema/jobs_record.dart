import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JobsRecord extends FirestoreRecord {
  JobsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "outputUrl" field.
  String? _outputUrl;
  String get outputUrl => _outputUrl ?? '';
  bool hasOutputUrl() => _outputUrl != null;

  // "outputPath" field.
  String? _outputPath;
  String get outputPath => _outputPath ?? '';
  bool hasOutputPath() => _outputPath != null;

  // "updateAt" field.
  DateTime? _updateAt;
  DateTime? get updateAt => _updateAt;
  bool hasUpdateAt() => _updateAt != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _status = snapshotData['status'] as String?;
    _notes = snapshotData['notes'] as String?;
    _outputUrl = snapshotData['outputUrl'] as String?;
    _outputPath = snapshotData['outputPath'] as String?;
    _updateAt = snapshotData['updateAt'] as DateTime?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('jobs');

  static Stream<JobsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => JobsRecord.fromSnapshot(s));

  static Future<JobsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => JobsRecord.fromSnapshot(s));

  static JobsRecord fromSnapshot(DocumentSnapshot snapshot) => JobsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static JobsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      JobsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'JobsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is JobsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createJobsRecordData({
  String? type,
  String? status,
  String? notes,
  String? outputUrl,
  String? outputPath,
  DateTime? updateAt,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'status': status,
      'notes': notes,
      'outputUrl': outputUrl,
      'outputPath': outputPath,
      'updateAt': updateAt,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class JobsRecordDocumentEquality implements Equality<JobsRecord> {
  const JobsRecordDocumentEquality();

  @override
  bool equals(JobsRecord? e1, JobsRecord? e2) {
    return e1?.type == e2?.type &&
        e1?.status == e2?.status &&
        e1?.notes == e2?.notes &&
        e1?.outputUrl == e2?.outputUrl &&
        e1?.outputPath == e2?.outputPath &&
        e1?.updateAt == e2?.updateAt &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(JobsRecord? e) => const ListEquality().hash([
        e?.type,
        e?.status,
        e?.notes,
        e?.outputUrl,
        e?.outputPath,
        e?.updateAt,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is JobsRecord;
}
