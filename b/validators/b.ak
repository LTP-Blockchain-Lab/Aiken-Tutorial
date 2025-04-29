use aiken/collection/list
use aiken/primitive/bytearray
use aiken/primitive/string

// Hàm chính tạo khóa từ mảng 4 số nguyên
pub fn genKey(start: List<Int>) -> String {
  // Tạo từng tập hợp 4 chữ số thập lục phân
  let set_1 = generate_set(list.at(start, 0) |> unwrap_or(1))
  let set_2 = generate_set(list.at(start, 1) |> unwrap_or(1))
  let set_3 = generate_set(list.at(start, 2) |> unwrap_or(1))
  let set_4 = generate_set(list.at(start, 3) |> unwrap_or(1))
  
  // Lắp ghép các set theo định dạng yêu cầu
  // x11x12x13x14-x22x23x24x21-x33x34x31x32-x44x41x42x43
  
  let part1 = string.concat(
    int_to_hex_char(list.at(set_1, 0) |> unwrap_or(0)),
    string.concat(
      int_to_hex_char(list.at(set_1, 1) |> unwrap_or(0)),
      string.concat(
        int_to_hex_char(list.at(set_1, 2) |> unwrap_or(0)),
        int_to_hex_char(list.at(set_1, 3) |> unwrap_or(0)),
      ),
    ),
  )
  
  let part2 = string.concat(
    int_to_hex_char(list.at(set_2, 1) |> unwrap_or(0)),
    string.concat(
      int_to_hex_char(list.at(set_2, 2) |> unwrap_or(0)),
      string.concat(
        int_to_hex_char(list.at(set_2, 3) |> unwrap_or(0)),
        int_to_hex_char(list.at(set_2, 0) |> unwrap_or(0)),
      ),
    ),
  )
  
  let part3 = string.concat(
    int_to_hex_char(list.at(set_3, 2) |> unwrap_or(0)),
    string.concat(
      int_to_hex_char(list.at(set_3, 3) |> unwrap_or(0)),
      string.concat(
        int_to_hex_char(list.at(set_3, 0) |> unwrap_or(0)),
        int_to_hex_char(list.at(set_3, 1) |> unwrap_or(0)),
      ),
    ),
  )
  
  let part4 = string.concat(
    int_to_hex_char(list.at(set_4, 3) |> unwrap_or(0)),
    string.concat(
      int_to_hex_char(list.at(set_4, 0) |> unwrap_or(0)),
      string.concat(
        int_to_hex_char(list.at(set_4, 1) |> unwrap_or(0)),
        int_to_hex_char(list.at(set_4, 2) |> unwrap_or(0)),
      ),
    ),
  )
  
  // Ghép tất cả các phần lại với nhau
  string.concat(
    part1, 
    string.concat(
      @"-", 
      string.concat(
        part2, 
        string.concat(
          @"-", 
          string.concat(
            part3,
            string.concat(
              @"-",
              part4
            )
          )
        )
      )
    )
  )
}

// Sinh ra một tập hợp 4 số từ một số đầu vào
fn generate_set(x: Int) -> List<Int> {
  // 1. Không thay đổi x
  let x1 = x
  
  // 2. Nếu x là số chẵn thì (x + 2) % 16, nếu không thì (x - 2) % 16
  let x2 = 
    if x % 2 == 0 {
      (x + 2) % 16
    } else {
      (x - 2 + 16) % 16  // +16 để đảm bảo kết quả không âm
    }
  
  // 3. Nếu x là số nguyên tố thì (x * 4) % 16, nếu không thì (x / 4) % 16
  let x3 = 
    if is_prime(x) {
      (x * 4) % 16
    } else {
      (x / 4) % 16
    }
  
  // 4. Nếu 15 chia hết cho x, đổi thành (x + 8) % 16, nếu không thì (x - 8) % 16
  let x4 = 
    if x != 0 && 15 % x == 0 {
      (x + 8) % 16
    } else {
      (x - 8 + 16) % 16  // +16 để đảm bảo kết quả không âm
    }
  
  // Trả về list 4 giá trị
  [x1, x2, x3, x4]
}

// Chuyển đổi số (0-15) thành ký tự hex tương ứng
fn int_to_hex_char(n: Int) -> String {
  if n < 10 {
    // Số 0-9
    string.from_int(n)
  } else {
    // Chữ cái A-F
    when n is {
      10 -> @"A"
      11 -> @"B"
      12 -> @"C"
      13 -> @"D"
      14 -> @"E"
      15 -> @"F"
      _ -> @"0"  // Không xảy ra
    }
  }
}

// Kiểm tra số nguyên tố 
fn is_prime(n: Int) -> Bool {
  if n <= 1 {
    False
  } else if n <= 3 {
    True
  } else if n % 2 == 0 || n % 3 == 0 {
    False
  } else {
    check_prime(n, 5)
  }
}

// Hỗ trợ kiểm tra số nguyên tố
fn check_prime(n: Int, i: Int) -> Bool {
  if i * i > n {
    True
  } else if n % i == 0 || n % (i + 2) == 0 {
    False
  } else {
    check_prime(n, i + 6)
  }
}

// Helper để unwrap Option
fn unwrap_or(opt: Option<a>, default: a) -> a {
  when opt is {
    Some(value) -> value
    None -> default
  }
}

// Test case
test example() {
  genKey([8, 10, 2, 6]) == @"8A2A-C3BA-1924-A682"
}