/// FileName model_util
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:30
///
/// @Description TODO

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}