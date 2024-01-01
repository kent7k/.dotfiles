# image_processing_test.py
import unittest
from unittest.mock import patch, MagicMock
import image_processing


class TestImageProcessing(unittest.TestCase):

    @patch('cv2.imread')
    @patch('cv2.imwrite')
    def test_negaposi(self, mock_imwrite, mock_imread):
        mock_image = MagicMock()
        mock_imread.return_value = mock_image
        result = image_processing.negaposi("fake_path")
        mock_imwrite.assert_called_with("fake_path", result)
        self.assertIsNotNone(result)

    @patch('builtins.open', new_callable=unittest.mock.mock_open)
    def test_write_log_file(self, mock_open):
        processed_files = ["image1.jpg", "image2.jpg"]
        image_processing.write_log_file("fake_path", "parent_dir", processed_files)
        mock_open.assert_called_with("fake_path/parent_dir.md", 'w')
        handle = mock_open()
        handle.write.assert_any_call("![](image1.jpg)\n\n")
        handle.write.assert_any_call("![](image2.jpg)\n\n")

if __name__ == '__main__':
    unittest.main()
