from selenium import webdriver
import time
import sys

browser=webdriver.Firefox()
browser.get("http://testphp.vulnweb.com/userinfo.php")
cookies = browser.get_cookies()
for cookie in cookies:
    print(cookie)
    
# browser.quit()
