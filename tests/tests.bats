@test "Opening Rundeck on port 80." {
  run curl http://localhost/
  [ "$status" -eq 0 ]
}

@test "Opening Rundeck on port 443." {
  run curl --insecure https://localhost/
  [ "$status" -eq 0 ]
}

@test "Logging in to Rundeck." {
  run curl --insecure https://localhost/rundeck/user/login --cookie-jar cookies.txt -F 'j_username=admin' -F 'j_password=admin' 
  [ "${status}" -eq 0 ]
}

@test "Checking for cookies.txt." {
  run test -f cookies.txt
  [ "${status}" -eq 0 ]
}

@test "Checking System info." {
  run curl --insecure https://localhost/menu/systemInfo --cookie cookies.txt
  [ "${status}" -eq 0 ]
  [ $(expr "${output}" : "ACTIVE") -eq 0 ]
}

@test "Logging out of Rundeck." {
  run curl --insecure --cookie-jar cookies.txt https://localhost/user/logout
  [ "${status}" -eq 0 ]
}

@test "Removing cookies.txt." {
 run rm cookies.txt
 [ "${status}" -eq 0 ]
}
