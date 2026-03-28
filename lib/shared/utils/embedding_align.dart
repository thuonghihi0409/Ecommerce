/// Kích thước cột `vector` trong Supabase (knowledge_base / match_knowledge).
/// Model như `gemini-embedding-001` có thể trả 3072 chiều — phải cắt/pad cho khớp.
const int kKnowledgeVectorDimension = 768;

List<double> alignEmbeddingToKnowledgeColumn(Iterable<double> values) {
  final list = List<double>.from(values);
  if (list.length > kKnowledgeVectorDimension) {
    return list.sublist(0, kKnowledgeVectorDimension);
  }
  if (list.length < kKnowledgeVectorDimension) {
    return [
      ...list,
      ...List<double>.filled(
        kKnowledgeVectorDimension - list.length,
        0,
      ),
    ];
  }
  return list;
}

/// Chuỗi literal cho tham số RPC kiểu text → pgvector.
String formatVectorLiteral(List<double> aligned) {
  assert(
    aligned.length == kKnowledgeVectorDimension,
    'Expected $kKnowledgeVectorDimension dims, got ${aligned.length}',
  );
  return '[${aligned.map((e) => e.toStringAsFixed(8)).join(',')}]';
}
