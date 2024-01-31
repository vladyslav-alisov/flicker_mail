class AttachmentNTW {
  String filename;
  String contentType;
  int size;

  AttachmentNTW({
    required this.filename,
    required this.contentType,
    required this.size,
  });

  factory AttachmentNTW.fromJson(Map<String, dynamic> json) => AttachmentNTW(
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
