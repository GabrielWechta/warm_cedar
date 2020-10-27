from selenium import webdriver
import time
import sys

browser=webdriver.Firefox()
browser.get("https://" + sys.argv[1])
cookies = browser.get_cookies()
for cookie in cookies:
    print(cookie)
    
# browser.quit()
