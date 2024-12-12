import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
def getHtmlSource(prmSearchString, prmStoreType):
    
    # Configure Chrome options
    options = Options()
    options.headless = True
    options.add_argument("--window-size=1920,1200")
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    options.add_argument(f"user-agent={headers['User-Agent']}")

    # Prepare the URL based on store type
    l_URL = ""
    if prmStoreType == "AMAZON":
        prmSearchString = prmSearchString.replace(" ", "+")
        l_URL = "https://www.amazon.eg/s?k="
    elif prmStoreType == "NOON":
        prmSearchString = prmSearchString.replace(" ", "+")
        l_URL = "https://www.noon.com/egypt-en/search/?q="


    # Initialize the WebDriver
    driver = webdriver.Chrome(options=options)

    # Fetch the HTML source
    print("Fetching HTML source from:", l_URL + prmSearchString.replace(" ", "+"))
    driver.get(l_URL + prmSearchString.replace(" ", "+"))

    # Add an explicit wait to ensure the presence of search results
    try:
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, '.s-result-list')))
        print("Search results loaded successfully.")
    except TimeoutException:
        print("Timeout: Search results not loaded within 10 seconds.")
        driver.quit()
        return None

    htmlData = driver.page_source
    print("HTML source retrieved successfully.")

    # Parse the HTML source using BeautifulSoup
    l_soup = BeautifulSoup(htmlData, 'html.parser')
    print("HTML parsed successfully.")

    # Quit the WebDriver
    driver.quit()

    return l_soup

def getAmazonData(prmSearchString):
    productList = []

    # Get HTML source from Amazon
    htmlSourceData = getHtmlSource(prmSearchString, "AMAZON")
    if htmlSourceData is None:
        return productList

    # Find all product entries
    productEntries = htmlSourceData.find_all('div', class_='s-result-item')

    productCounter = 0
    for entry in productEntries:
        if productCounter >= 12:
            break

        # Skip the first two products
        if productCounter >= 2:
            product = {}
            title_element = entry.find('span', class_='a-text-normal')
            if title_element:
                title = title_element.text.strip()
                price_element = entry.find('span', class_='a-price')
                if price_element:
                    price_string = price_element.find('span', class_='a-offscreen').text.strip()
                    price_string = price_string.replace('\u200f', '')  # Remove '\u200f' character
                    price_string = price_string.replace('جنيه', '')  # Remove currency symbol
                    price_string = price_string.replace('\xa0', '').replace(',', '')  # Remove non-breaking space and commas
                    
                    try:
                      price = float(price_string.split()[0])  # Extract price value and convert to int
                    except ValueError:
                          price = None

                    
                    
                else:
                    price = "None"
                    currency = "None"

                # Retrieve product link
                link_element = entry.find('a', class_='a-link-normal')
                if link_element:
                    link = "https://www.amazon.eg" + link_element['href']
                else:
                    link = "None"
                img_element = entry.find('img', class_='s-image')
                if img_element:
                    img_url = img_element['src']
                else:
                    img_url = "None"

                product = {
                    "title": str(title),
                    "price": price, 
                    "image": img_url,
                    "link": link
                }

                productList.append(product)
                

        productCounter += 1

    # Print productList for debugging
    print("Amazon Product List:", productList)

    return productList

def getNoonData(url):
    
    options = Options()
    options.headless = False

    driver = webdriver.Chrome(options=options)
    driver.get(url)

    try:
        WebDriverWait(driver, 30).until(EC.visibility_of_all_elements_located((By.XPATH, "//div[@data-qa='product-name']")))
        WebDriverWait(driver, 30).until(EC.visibility_of_all_elements_located((By.XPATH, "//strong[@class='amount']")))

        product_elements = driver.find_elements(By.XPATH, "//a[contains(@id, 'productBox-')]")

        product_data_noon = []
        counter = 1

        productCounter = 0
        for product_element in product_elements:
            if productCounter == 10:
                break

            productCounter += 1
            name_element = product_element.find_element(By.XPATH, ".//div[@data-qa='product-name']")
            title = name_element.get_attribute("title").strip()
            currency_element = product_element.find_element(By.XPATH, ".//strong[@class='amount']/preceding-sibling::span[@class='currency']")
            currency = currency_element.text.strip()
            price_text = product_element.find_element(By.XPATH, ".//strong[@class='amount']").text.strip()
          # Remove commas from the price text
            price_text_without_commas = price_text.replace(',', '')
          # Convert the resulting string to an integer
            price = int(price_text_without_commas)

            link = product_element.get_attribute("href")
            
            # Retrieve image URL
            try:
              img_element = product_element.find_element(By.XPATH, ".//img[@class='sc-d13a0e88-1 cindWc']")
              img_url = img_element.get_attribute('src')
              img_url = img_url.replace("?format=avif&width=240", "")
            except NoSuchElementException:
                  # Handle the case where the image element is not found
                 print("Image element not found for product:", title)
            
            
            
            product = {
                    "title": str(title),
                    "price": price, 
                    "image": img_url,
                    "link": link
                }

            product_data_noon.append(product)
            
            counter += 1
    finally:
        driver.quit()
        

    return product_data_noon

def getBtechData(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raise an HTTPError for bad status codes
    except requests.exceptions.RequestException as e:
        print("Error fetching page:", e)
        return []  # Return an empty list if there's an error

    soup = BeautifulSoup(response.content, 'html.parser')

    products = []
    counter = 1
    productCounter = 0

    for product in soup.find_all('div', class_='product-item-view'):
        if productCounter == 10:
            break
        try:
            title = product.find('h2', class_='plpTitle').text.strip()
            img_url = product.find('img', class_='product-image-photo')['src']
            price_text = product.find('span', class_='price-wrapper').text.strip().replace('جنيه', '').replace(',', '').strip()
            price = int(price_text)
            relative_link = product.find('a', class_='listingWrapperSection')['href']
            link = urljoin(url, relative_link)
        except AttributeError as e:
            print("Error parsing product data:", e)
            continue  # Skip this product if any required data is missing

        product_info = {
            "title": title,
            "price": price, 
            "image": img_url,
            "link": link
        }
        products.append(product_info)
        counter += 1
        productCounter += 1  # Increment the product counter

    return products



def getDubizzeleData(search_string):
    base_url = "https://www.dubizzle.com.eg/en/ads/"
    search_url = urljoin(base_url, f"q-{search_string.replace(' ', '-')}")
    response = requests.get(search_url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        product_list = []
        counter = 0  # Initialize counter
        for li in soup.find_all('li', class_=''):
            product = {}
            try:
                product['title'] = li.find('h2', class_='a5112ca8').text.strip()
            except AttributeError:
                product['title'] = 'Title not available'
            price_element = li.find('span', class_='_95eae7db')
            price_text = price_element.text.strip().replace('EGP', '').replace(',', '').strip() if price_element else None
            product['price'] = int(price_text) if price_text else 'Price not available'
            link_element = li.find('a', href=True)
            product['link'] = urljoin(base_url, link_element['href']) if link_element else 'Link not available'
            img_element = li.find('img', class_='_76b7f29a')
            product['image'] = img_element['src'] if img_element else 'Image not available'
            product_list.append( product)  # Add counter to each product
            counter += 1  # Increment counter
            if counter >= 20:  # Break the loop if counter reaches 11 (after adding 10 products)
                break
        return product_list
    else:
        print("Failed to fetch search results")
        return []




