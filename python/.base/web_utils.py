import requests


class WebUtils:
    # ... other methods ...

    @staticmethod
    def get_validated_response(url):
        """
        Sends a GET request to the specified URL and validates the response.

        :param url: The URL to send the request to.
        :return: The response object if the request was successful, otherwise None.
        """
        try:
            response = requests.get(url)
            if response.status_code == 200:
                return response
            else:
                print(
                    f"Failed to retrieve the webpage: {url} - Status Code: {response.status_code}"
                )
                return None
        except requests.RequestException as e:
            print(f"Request failed for {url}: {e}")
            return None
