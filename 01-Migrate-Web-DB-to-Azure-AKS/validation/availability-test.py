import requests
import time


OK = 0
FAILED = 0
URL = 'https://shop.thesis.analyticsvn.com'
while (True):    
    start_time = time.time()
    response = requests.get(URL)
    elapsed_time = time.time() - start_time
    if (response.status_code == 503):
        FAILED=FAILED+1
        print('\nFailed ' + str(FAILED) + ':' + str(response.status_code) + '|' + str(elapsed_time))
    else:
        OK = OK + 1
        print('\nCount ' + str(OK) + ':' + str(response.status_code) + '|' + str(elapsed_time))

        
