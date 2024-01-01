import unittest
from unittest.mock import patch
import file_management

class TestFileManagement(unittest.TestCase):

    @patch('subprocess.check_output')
    def test_select_and_move_directories(self, mock_subprocess):
        # Mock subprocess output and test function behavior

    @patch('os.rename')
    @patch('glob.glob')
    def test_rename_files(self, mock_glob, mock_rename):
        # Mock glob and os.rename, then test function behavior

    # More tests for other functions...

if __name__ == '__main__':
    unittest.main()
