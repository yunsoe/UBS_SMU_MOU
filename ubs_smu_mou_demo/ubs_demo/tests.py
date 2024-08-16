from django.test import TestCase
from django.urls import reverse


class SimpleTestCase(TestCase):
    def test_home_page_status_code(self):
        """
        Test if the home page returns a status code of 200.
        """
        response = self.client.get(reverse('index'))
        self.assertEqual(response.status_code, 200)
