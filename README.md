# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


- Run rake task to get all companies symbol and name for one time only while setup
	--> bin/rails get_companies_details 



- If admin add new company from active admin and in case that company is not present on third party toll then it will give all the rate equals to 0 (current rate, end rate etc)

Stepup/ Desc -
  For Admin
    
    1. Set api token from admin panel. (Tokens for finnhub and iexcloud) 
    
    2. Run rake task using following command :
          --> bin/rails get_companies_details
        This task will fetch and saave companies name and symbol
    
    3.  Create plans.
    
    4.  Create plan offers. In this admin can add percentage amount (that how much discount he
        wants to give to the subscriber using refer code)
    
    5.  Add trade for the day from Today's Trade in active admin. 
    
    6.  Pay Amount : List of users who used refer code and unsubscribe the plan, admin can confirm the 
        payment, after confirmation the bonus will be displayed on the collect bonus screen and user can collect it (after collection amount will be added to his wallet)
    
    7.  Payment : List of the user who subscribed and paid sucessfully.

    8. Contact : List of the contacts that tried to connect via contact us form, admin can also reply
       from here.

    9. NewLetter : Admin can create newsletter and by cliking on publish, all the usera that have 
       subscribed for newletter will receive the newsletter email.

    10. Subscription : List of the users who has subscribed.

    11. Referral User : List of the users who referred another user.

  For User

    1. Sign up
        Case - If user have any referral code then he can use it while sign up and after confirmation from admin that bonus will be displayed on collect bonus (on users profile)
        User can collect it and will be added in wallet.

    2. Confirm account

    3. Sign in

    4. Subscribe 

    5. Note - If any user update his/her mail id from his/her profile page then he/she have to confirm his
       email on updated mail id
  --> If not confirmed then new email will not be updated. User have to use previous one only.
