# utils_test.py
import unittest
import utils

class TestUtils(unittest.TestCase):

    def test_atoi(self):
        self.assertEqual(utils.atoi("123"), 123)
        self.assertEqual(utils.atoi("abc"), "abc")

    def test_natural_keys(self):
        self.assertEqual(utils.natural_keys("image20"), [20])
        self.assertEqual(utils.natural_keys("image"), ["image"])

if __name__ == '__main__':
    unittest.main()
