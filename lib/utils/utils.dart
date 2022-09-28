bool isNumeric( String s){

  if(s.isEmpty) return false;

  final n = num.tryParse(s);

  return ( n == null) ? false:true;
}

bool isNumericInt( String s){
  s=s.replaceAll( RegExp('[.]'),'');
  if(s.isEmpty) return false;
  final n = int.tryParse(s);
  if (n! <= 0) return false;
  return ( n == null) ? false:true;
}
bool isNumericBool( String s){

  if(s.isEmpty) return false;
  final n = int.tryParse(s);
  if (n! <= 0.0) return false;
  return ( n == null) ? false:true;
}
bool isNumericSupZero( String s){
  s=s.substring(3).replaceAll(RegExp('[.]'), '').replaceAll(RegExp('[,]'), '.');
  if(s.isEmpty) return false;
  if(s=='0') return false;
  final n = num.tryParse(s);
  if (n! <= 0.0) return false;
  return ( n == null) ? false:true;
}
bool validateText(String value) {
  return RegExp(r"^[a-zA-Z áéíóúÁÉÍÓÚÑñ]+$").hasMatch(value) ? true : false;
}
String flattenPhoneNumber(String phoneStr) {
  return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
    return m[0] == "+" ? "+" : "";
  });
}