class AttachmentNetworkEntity {
  String filename;
  String contentType;
  int size;

  AttachmentNetworkEntity({
    required this.filename,
    required this.contentType,
    required this.size,
  });

  factory AttachmentNetworkEntity.fromJson(Map<String, dynamic> json) => AttachmentNetworkEntity(
        filename: json["filename"],
        contentType: json["contentType"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "contentType": contentType,
        "size": size,
      };
}
