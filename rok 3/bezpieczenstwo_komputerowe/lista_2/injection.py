from selenium import webdriver
import sys

browser = webdriver.Firefox()

browser.get("http://" + sys.argv[1])

browser.add_cookie({'name': 'login', 'value': sys.argv[2]})

browser.refresh()

