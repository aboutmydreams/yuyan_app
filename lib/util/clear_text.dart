String clearText(String text, int maxn) {
  // RegExp exp = new RegExp(r'<[^>]+>'); // html
  RegExp emojiReg = RegExp(
      r"\ud83c[\udf00-\udfff] | \ud83d[\udc00-\ude4f] | \ud83d[\ude80-\udeff]"); // emoji
  String retext = text.replaceAll(emojiReg, '');
  retext = retext.replaceAll("\n", "");
  if (retext.length > maxn) {
    retext = retext.substring(0, maxn - 2) + "..";
  }
  return retext;
}
