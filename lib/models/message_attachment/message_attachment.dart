class MessageAttachment {
  String filename;
  String contentType;
  int size;
  String filePath;

  MessageAttachment({
    required this.filename,
    required this.contentType,
    required this.size,
    required this.filePath,
  });
}
