import 'dart:convert';

class ChatBotResponse {
  String? jawaban;
  Sumber? sumber;

  ChatBotResponse({
    this.jawaban,
    this.sumber,
  });

  factory ChatBotResponse.fromRawJson(String str) => ChatBotResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) => ChatBotResponse(
    jawaban: json["jawaban"],
    sumber: json["sumber"] == null ? null : Sumber.fromJson(json["sumber"]),
  );

  Map<String, dynamic> toJson() => {
    "jawaban": jawaban,
    "sumber": sumber?.toJson(),
  };
}

class Sumber {
  String? hasilOcrTeks21Pdf;
  String? hasilOcrTeks211Pdf;

  Sumber({
    this.hasilOcrTeks21Pdf,
    this.hasilOcrTeks211Pdf,
  });

  factory Sumber.fromRawJson(String str) => Sumber.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sumber.fromJson(Map<String, dynamic> json) => Sumber(
    hasilOcrTeks21Pdf: json["hasil_ocr_teks21.pdf"],
    hasilOcrTeks211Pdf: json["hasil_ocr_teks21 (1).pdf"],
  );

  Map<String, dynamic> toJson() => {
    "hasil_ocr_teks21.pdf": hasilOcrTeks21Pdf,
    "hasil_ocr_teks21 (1).pdf": hasilOcrTeks211Pdf,
  };
}
