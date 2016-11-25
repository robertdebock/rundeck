@test "Checking port 80" {
  run curl http://localhost/
  [ $result -eq 0 ]
}

@test "Checking port 443" {
  run curl --insecure https://localhost/
  [ $result -eq 0 ]
}
