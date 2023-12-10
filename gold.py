import requests
from bs4 import BeautifulSoup
webhook_url = 'https://discord.com/api/webhooks/1183302918380728410/eHWU3xp_duL2pQHQoMtQEzJwKGMh4Yp1v69rkYs9VgOr0MqFeRgkMqPUpSPYttgXbC_B'


def get_gold_prices(url):
    try:
        # Fetch the webpage content
        response = requests.get(url)
        if response.status_code != 200:
            return "Error: Unable to access the webpage."

        # Parse the webpage content
        soup = BeautifulSoup(response.content, 'html.parser')

        # Extract relevant information
        data = {}

        data['Price Datail'] = soup.find('div', class_='right-listing-weight').text.strip() if soup.find('div', class_='right-listing-weight') else 'Not found'
        data['Gold Info'] = soup.find('div', class_='top-bar').text.strip() if soup.find('div', class_='top-bar') else 'Not found'
        data['1oz price'] = soup.find('div', class_='australian-gold-page-deatil-second').text.strip() if soup.find('div', class_='australian-gold-page-deatil-second') else 'Not found'
        # # Assuming that the 'span' with class 'gold' is inside the 'div' with class 'top-bar'
        # gold_spans = soup.find('div', class_='top-bar').find_all('span', class_='gold')
        # if gold_spans and len(gold_spans) >= 2:
        #     data['Gold Bid'] = gold_spans[0].text.strip()
        #     data['Gold Ask'] = gold_spans[1].text.strip()
        # else:
        #     data['Gold Bid'] = 'Not found'
        #     data['Gold Ask'] = 'Not found'

        # Add more data extraction logic here if needed

        return data
    except Exception as e:
        return f"An error occurred: {e}"

# URL of the webpage to scrape
url = "https://www.melbournegoldcompany.com.au/buy-bullion/5oz-gold-bar-perth-mint-info.php"

# Get the gold prices and related information
gold_prices_info = get_gold_prices(url)

# Format the message content
message_content = '\n'.join(f"{key}: {value}" for key, value in gold_prices_info.items())

data = {
    'content': message_content,
    'username': 'Gold Price Bot'
}

# Send POST request to Discord Webhook URL
headers = {
    'Content-Type': 'application/json'
}
response = requests.post(webhook_url, json=data, headers=headers)

# Check the response
if response.status_code == 204:
    print('Message sent successfully')
else:
    print('Failed to send message:', response.status_code, response.text)
