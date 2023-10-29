function test_moveAllToTarget() {
  initialize
  moveAllToTarget main onlyDirectories
  validate "onlyDirectories" && cleanup

  initialize
  moveAllToTarget main All
  validate "All" && cleanup

  initialize
  moveAllToTarget main onlyFiles
  validate "onlyFiles" && cleanup
}

function initialize() {
  # Setup test environment
  mkdir test_env
  cd test_env
  mkdir dir1 dir2 dir3 main
  touch file1.txt file2.txt file3.txt
}

function validate() {
  case $1 in
    onlyDirectories)
      # Check if only directories have been moved.
      [ ! -d dir1 ] && [ ! -d dir2 ] && [ ! -d dir3 ] && echo "Test for onlyDirectories: PASSED" || echo "Test for onlyDirectories: FAILED"
      ;;
    All)
      # Check if both directories and files have been moved.
      [ ! -d dir1 ] && [ ! -d dir2 ] && [ ! -d dir3 ] && [ ! -f file1.txt ] && [ ! -f file2.txt ] && [ ! -f file3.txt ] && echo "Test for All: PASSED" || echo "Test for All: FAILED"
      ;;
    onlyFiles)
      # Check if only files have been moved.
      [ ! -f file1.txt ] && [ ! -f file2.txt ] && [ ! -f file3.txt ] && echo "Test for onlyFiles: PASSED" || echo "Test for onlyFiles: FAILED"
      ;;
    *)
      echo "Invalid test type."
      ;;
  esac
}

function cleanup() {
  # Clean up the test environment.
  cd ..
  rm -rf test_env
}
