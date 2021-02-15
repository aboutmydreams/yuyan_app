// class ConvertJson {
//   Data data;

//   ConvertJson({this.data});

//   ConvertJson.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String content;

//   Data({this.content});

//   Data.fromJson(Map<String, dynamic> json) {
//     content = json['content'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['content'] = this.content;
//     return data;
//   }
// }
