
enum EMMessageBodyType {
  TXT, // 文字消息
  IMAGE, // 图片消息
  VOICE, // 音频消息
}
enum EMMessageDirection {
  RECIEVE, // 文字消息
  SEND, // 图片消息
}

class EMMessage{

   EMMessageDirection? direction;
   String? content;
   EMMessageBodyType? msgType;
   DateTime? time;
}