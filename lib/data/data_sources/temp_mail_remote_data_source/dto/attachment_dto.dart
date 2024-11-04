class AttachmentDto {
  String filename;
  String contentType;
  int size;

  AttachmentDto({
    required this.filename,
    required this.contentType,
    required this.size,
  });

  factory AttachmentDto.fromJson(Map<String, dynamic> json) => AttachmentDto(
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
