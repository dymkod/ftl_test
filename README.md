# README


* Setup
  ```
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed # <= create some test users, for easier testing
  ```

* Description
  - use one of seed users emails created in `Setup` section for sign in
  - get the access token(JWT) `/auth/login?email={PUT_EMAIL_HERE}`,
  - use that token to process some link: 

    ```
     curl -X POST -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1LCJleHAiOjE2MjU2MDY1MjV9._6DRQLhm43S8mu1z7dchZsoELjYCA0POQVTAWDprzvA" 'http://localhost:3000/urls?url=https://www.booking.com/searchresults.ru.html'
     ```
     
   - in response you will get a short code, use it for checking link in browser, just go to `http://localhost:300/urls/{PUT_CODE_HERE}`
   - result of previous steps would be a hash, in this format: `{url: 'https://www.booking.com/searchresults.ru.html'}`
   
   
