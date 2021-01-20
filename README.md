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

- If any user update his/her mail id from his/her profile page then he/she have to confirm his email on updated mail id
	--> If not confirmed then new email will not be updated. User have to use previous one only.

- If admin add new company from active admin and in case that company is not present on third party toll then it will give all the rate equals to 0 (current rate, end rate etc)