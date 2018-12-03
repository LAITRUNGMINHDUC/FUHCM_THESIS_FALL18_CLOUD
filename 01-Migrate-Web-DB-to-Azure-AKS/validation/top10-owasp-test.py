import requests
import time

OK = 0
FAILED = 0
URL = 'https://shop.thesis.analyticsvn.com'
# NEED TO READ THE QUERY IN TXT file
while (True):    
    start_time = time.time()
    response = requests.get(URL)
    elapsed_time = time.time() - start_time
    if (response.status_code != 403):
        FAILED = FAILED+1
        print('\nFailed to block ' + str(FAILED) + ':' + str(response.status_code) + '|' + str(elapsed_time))
    else:
        OK = OK + 1
        print('\nBlock ' + str(OK) + ':' + str(response.status_code) + '|' + str(elapsed_time))