

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  // static String getPinyin(String str) {
  //   return PinyinHelper.getShortPinyin(str).substring(0, 1).toUpperCase();
  // }
}
